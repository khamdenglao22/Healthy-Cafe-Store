part of 'login_cubit.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  const LoginState({
    this.passwordVisible = true,
    this.error,
    this.loginStatus,
  });

  final bool passwordVisible;
  final String? error;
  final LoginStatus? loginStatus;

  @override
  List<Object> get props => [
        {
          passwordVisible,
          error,
          loginStatus,
        }
      ];
  LoginState copyWith({
    bool? passwordVisible,
    final String? error,
    final LoginStatus? loginStatus,
  }) {
    return LoginState(
      passwordVisible: passwordVisible ?? this.passwordVisible,
      loginStatus: loginStatus ?? this.loginStatus,
      error: error ?? this.error,
    );
  }
}
