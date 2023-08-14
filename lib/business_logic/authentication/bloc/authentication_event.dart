part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequested extends AuthenticationEvent {
  final String email;
  final String password;

  SignUpRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
