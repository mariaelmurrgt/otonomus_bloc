part of 'signup_bloc.dart';

final class SignupState extends Equatable {
  const SignupState(this.status, this.email, this.firstName, this.lastName,
      this.password, this.errorMessage);

  final SignupStatus status;
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String errorMessage;

  SignupState copyWith({
    SignupStatus? status,
    String? email,
    String? firstName,
    String? lastName,
    String? password,
    String? errorMessage,
  }) {
    return SignupState(
      status ?? this.status,
      email ?? this.email,
      firstName ?? this.firstName,
      lastName ?? this.lastName,
      password ?? this.password,
      errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props =>
      [status, email, firstName, lastName, password, errorMessage];
}
