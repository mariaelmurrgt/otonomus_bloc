import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:otonomus/data/models/user_model.dart';
import 'package:otonomus/data/repository/auth_repository.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  DrawerBloc(
    AuthRepository authRepository,
  )   : _authRepository = authRepository,
        super(DrawerState(UserModel.defaultUser)) {
    on<CheckUser>(_checkUser);
    on<LogOut>(_onLogOut);
  }

  final AuthRepository _authRepository;

  Future<void> _checkUser(CheckUser event, Emitter<DrawerState> emit) async {
    UserModel? user = await _authRepository.checkUserStatus();
    if (user != null) {
      emit(DrawerState(user));
      print('${user}');
    }
  }

  void _onLogOut(
    LogOut event,
    Emitter<DrawerState> emit,
  ) {
    emit(DrawerState(UserModel.defaultUser));
    _authRepository.LogOut();
    print('${state.user}');
  }
}
