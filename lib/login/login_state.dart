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
    this.nickname = '',
  });

  const LoginState.authenticated(User user, String nickname)
      : this._(
          status: LoginStatus.authenticated,
          user: user,
          nickname: nickname,
        );

  const LoginState.unauthenticated()
      : this._(status: LoginStatus.unauthenticated);

  final LoginStatus status;
  final User user;
  final String nickname;

  // NOTE: nickname doesn't  have to be part of this for now
  @override
  List<Object> get props => [status, user];
}
