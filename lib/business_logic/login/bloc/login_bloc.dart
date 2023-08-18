import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:otonomus/data/enums/enums.dart';
import 'package:otonomus/data/repository/auth_repository.dart';
import 'package:otonomus/navigation/handle_navigation.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(
    AuthRepository authRepository,
  )   : _authRepository = authRepository,
        super(LoginState(LoginStatus.initial, '', '', '')) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<ClearErrorLogIn>(_onClearError);
    on<LogOutClearEverything>(_onLogOutClearEverything);
  }

  final AuthRepository _authRepository;

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        email: event.email,
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        password: event.password,
      ),
    );
  }

  void _onClearError(
    ClearErrorLogIn event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        errorMessage: '',
      ),
    );
  }

  void _onLogOutClearEverything(
    LogOutClearEverything event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(
      status: LoginStatus.initial,
      email: '',
      password: '',
      errorMessage: '',
    ));
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      String error_message = await _authRepository.logIn(
        email: state.email,
        password: state.password,
      );
      print('done');
      if (error_message == '') {
        print('success');
        emit(state.copyWith(status: LoginStatus.success));
        HandleNavigation.popUntilFirst();
      } else {
        emit(state.copyWith(
            status: LoginStatus.failure, errorMessage: error_message));
      }
    } catch (e) {
      print('error: $e');
      emit(state.copyWith(
          status: LoginStatus.failure, errorMessage: 'Log in failed'));
    }
  }
}
