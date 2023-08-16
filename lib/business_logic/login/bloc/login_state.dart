part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState(this.status, this.email, this.password, this.errorMessage);

  final LoginStatus status;
  final String email;
  final String password;
  final String errorMessage;

  LoginState copyWith({
    LoginStatus? status,
    String? email,
    String? password,
    String? errorMessage,
  }) {
    return LoginState(
      status ?? this.status,
      email ?? this.email,
      password ?? this.password,
      errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, email, password, errorMessage];
}
