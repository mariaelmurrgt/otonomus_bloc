import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:otonomus/data/repository/auth_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;
  AuthenticationBloc({required this.authRepository})
      : super(UnAuthenticated()) {
    //on<SignUpRequested>(_signUpRequest);
  }

  // void _signUpRequest(
  //     SignUpRequested event, Emitter<AuthenticationState> emit) async {
  //   emit(Loading());
  //   try {
  //     await authRepository.signUp(email: event.email, password: event.password);
  //   } catch (e) {
  //     emit(UnAuthenticated());
  //   }
  // }
}
