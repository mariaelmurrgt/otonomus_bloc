part of 'drawer_bloc.dart';

final class DrawerState extends Equatable {
  const DrawerState(this.user);

  final UserModel user;

  DrawerState copyWith({
    UserModel? user,
  }) {
    return DrawerState(user ?? this.user);
  }

  @override
  List<Object> get props => [user];
}
