import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:meta/meta.dart';

/// {@template sign_in_anonymously_failure}
/// Thrown during the sign in with google process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInAnonymously.html
/// {@endtemplate}
class SignInAnonymouslyFailure implements Exception {
  /// {@macro log_in_with_google_failure}
  const SignInAnonymouslyFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory SignInAnonymouslyFailure.fromCode(String code) {
    switch (code) {
      case 'operation-not-allowed':
        return const SignInAnonymouslyFailure(
          'Operation is not allowed.  Please contact support.',
        );
      default:
        return const SignInAnonymouslyFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// {@template auth_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthRepository {
  /// {@macro auth_repository}
  AuthRepository({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  /// Whether or not the current environment is web
  /// Should only be overriden for testing purposes. Otherwise,
  /// defaults to [kIsWeb]
  @visibleForTesting
  bool isWeb = kIsWeb;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  /// Returns the current cached user.
  /// Defaults to [User.empty] if there is no cached user.
  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  // Starts the Sign In Anonymously Flow.
  ///
  /// Throws a [SignInAnonymouslyFailure] if an exception occurs.
  Future<void> signInAnonymously() async {
    try {
      await _firebaseAuth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw SignInAnonymouslyFailure.fromCode(e.code);
    } catch (_) {
      throw const SignInAnonymouslyFailure();
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
