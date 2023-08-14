part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Loading extends AuthenticationState {
  List<Object> get props => [];
}

class UnAuthenticated extends AuthenticationState {}
