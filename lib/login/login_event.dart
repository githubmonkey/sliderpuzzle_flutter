// ignore_for_file: public_member_api_docs

part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginLogoutRequested extends LoginEvent {}

class LoginUserChanged extends LoginEvent {
  @visibleForTesting
  const LoginUserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}
