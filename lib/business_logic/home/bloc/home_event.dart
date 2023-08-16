part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class GetAllProperties extends HomeEvent {}

final class SelectedPropertyChanged extends HomeEvent {
  const SelectedPropertyChanged(this.selectedProperty);

  final PropertyModel selectedProperty;
  @override
  List<Object> get props => [selectedProperty];
}

final class SelectedPageChanged extends HomeEvent {
  const SelectedPageChanged(this.availableSpace, this.newIndex);

  final AvailableSpace availableSpace;
  final int newIndex;

  @override
  List<Object> get props => [availableSpace, newIndex];
}
