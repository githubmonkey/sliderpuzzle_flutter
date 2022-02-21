// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:history_repository/history_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthRepository authRepository,
    required HistoryRepository historyRepository,
  })  : _authRepository = authRepository,
        _historyRepository = historyRepository,
        super(
          authRepository.currentUser.isNotEmpty
              ? LoginState.authenticated(
                  authRepository.currentUser,
                  historyRepository.getNickname(
                    authRepository.currentUser.id,
                  ))
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

  final HistoryRepository _historyRepository;

  void _onUserChanged(LoginUserChanged event, Emitter<LoginState> emit) {
    emit(
      event.user.isNotEmpty
          ? LoginState.authenticated(
              event.user,
              _historyRepository.getNickname(event.user.id),
            )
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
