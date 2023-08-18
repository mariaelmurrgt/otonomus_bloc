part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetAllProperties extends HomeEvent {
  const GetAllProperties();
  @override
  List<Object> get props => [];
}

class SelectedPropertyChanged extends HomeEvent {
  const SelectedPropertyChanged(this.selectedProperty);

  final PropertyModel selectedProperty;
  @override
  List<Object> get props => [selectedProperty];
}

class SelectedImageChanged extends HomeEvent {
  const SelectedImageChanged(this.index);
  final int index;

  @override
  List<Object> get props => [index];
}

class OnClear extends HomeEvent {
  const OnClear();
  @override
  List<Object> get props => [];
}
