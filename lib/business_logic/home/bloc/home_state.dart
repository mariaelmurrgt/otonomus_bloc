// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState(
      {required this.status,
      required this.properties,
      required this.selectedProperty,
      this.index = 0});

  final FetchPropertStatus status;
  final List<PropertyModel> properties;
  final PropertyModel selectedProperty;
  final int index;

  @override
  List<Object> get props => [status, properties, selectedProperty, index];

  HomeState copyWith({
    FetchPropertStatus? status,
    List<PropertyModel>? properties,
    PropertyModel? selectedProperty,
    int? index,
  }) {
    return HomeState(
      status: status ?? this.status,
      properties: properties ?? this.properties,
      selectedProperty: selectedProperty ?? this.selectedProperty,
      index: index ?? this.index,
    );
  }
}
