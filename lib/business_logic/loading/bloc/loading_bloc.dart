import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:otonomus/data/enums/enums.dart';
import 'package:otonomus/data/models/user_model.dart';
import 'package:otonomus/data/repository/auth_repository.dart';
import 'package:otonomus/navigation/handle_navigation.dart';

part 'loading_event.dart';
part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc(
    AuthRepository authRepository,
  )   : _authRepository = authRepository,
        super(LoadingState(AuthStatus.unkown)) {
    on<onLoadingCheckUserStatus>(_checkUserStaus);
  }

  final AuthRepository _authRepository;

  Future<void> _checkUserStaus(
    onLoadingCheckUserStatus event,
    Emitter<LoadingState> emit,
  ) async {
    UserModel? user = await _authRepository.checkUserStatus();
    print('user auth checked');
    if (user != null) {
      emit(LoadingState(AuthStatus.authenticated));
      print('user authenticated');
      HandleNavigation.pushNamedAndRemoveUntil('/home', (p0) => false);
    } else {
      emit(LoadingState(AuthStatus.unauthenticated));
      print('user unauthenticated');
      HandleNavigation.pushNamedAndRemoveUntil('/home', (p0) => false);
    }
  }
}
