part of 'drawer_bloc.dart';

sealed class DrawerEvent extends Equatable {
  const DrawerEvent();

  @override
  List<Object> get props => [];
}

final class CheckUser extends DrawerEvent {}

final class LogOut extends DrawerEvent {}
