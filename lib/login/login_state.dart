// ignore_for_file: public_member_api_docs

part of 'login_bloc.dart';

enum LoginStatus {
  authenticated,
  unauthenticated,
}

class LoginState extends Equatable {
  const LoginState._({
    required this.status,
    this.user = User.empty,
  });

  const LoginState.authenticated(User user)
      : this._(status: LoginStatus.authenticated, user: user);

  const LoginState.unauthenticated()
      : this._(status: LoginStatus.unauthenticated);

  final LoginStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
