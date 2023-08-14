import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:otonomus/data/enums/enums.dart';
import 'package:otonomus/data/repository/auth_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc(
    AuthRepository authRepository,
  )   : _authRepository = authRepository,
        super(SignupState(SignupStatus.initial, '', '', '', '', '')) {
    on<SignupEmailChanged>(_onEmailChanged);
    on<SignupPasswordChanged>(_onPasswordChanged);
    on<SignupFirstNameChanged>(_onFirstNameChanged);
    on<SignupLastNameChanged>(_onLastNameChanged);
    on<SignUpSubmitted>(_onSubmitted);
    on<ClearError>(_onClearError);
  }

  final AuthRepository _authRepository;

  void _onEmailChanged(
    SignupEmailChanged event,
    Emitter<SignupState> emit,
  ) {
    emit(
      state.copyWith(
        email: event.email,
      ),
    );
  }

  void _onPasswordChanged(
    SignupPasswordChanged event,
    Emitter<SignupState> emit,
  ) {
    emit(
      state.copyWith(
        password: event.password,
      ),
    );
  }

  void _onFirstNameChanged(
    SignupFirstNameChanged event,
    Emitter<SignupState> emit,
  ) {
    emit(
      state.copyWith(
        firstName: event.firstName,
      ),
    );
  }

  void _onLastNameChanged(
    SignupLastNameChanged event,
    Emitter<SignupState> emit,
  ) {
    emit(
      state.copyWith(
        lastName: event.lastName,
      ),
    );
  }

  void _onClearError(
    ClearError event,
    Emitter<SignupState> emit,
  ) {
    emit(
      state.copyWith(
        errorMessage: '',
      ),
    );
  }

  Future<void> _onSubmitted(
    SignUpSubmitted event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(status: SignupStatus.loading));
    try {
      String error_message = await _authRepository.signUp(
        email: state.email,
        password: state.password,
        firstName: state.firstName,
        lastName: state.lastName,
      );
      print('done');
      if (error_message == '') {
        emit(state.copyWith(status: SignupStatus.success));
      } else {
        emit(state.copyWith(
            status: SignupStatus.failure, errorMessage: error_message));
      }
      //emit(state.copyWith(status: Signuptatus.success));
    } catch (e) {
      print('error: $e');
      emit(state.copyWith(
          status: SignupStatus.failure, errorMessage: 'Sign up failed'));
    }
  }
}
