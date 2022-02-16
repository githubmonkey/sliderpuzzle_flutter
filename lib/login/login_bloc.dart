// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(
          authRepository.currentUser.isNotEmpty
              ? LoginState.authenticated(authRepository.currentUser)
              : const LoginState.unauthenticated(),
        ) {
    on<LoginUserChanged>(_onUserChanged);
    on<LoginLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authRepository.user.listen(
      (user) => add(LoginUserChanged(user)),
    );
  }

  final AuthRepository _authRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(LoginUserChanged event, Emitter<LoginState> emit) {
    emit(
      event.user.isNotEmpty
          ? LoginState.authenticated(event.user)
          : const LoginState.unauthenticated(),
    );
  }

  void _onLogoutRequested(
    LoginLogoutRequested event,
    Emitter<LoginState> emit,
  ) {
    unawaited(_authRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
