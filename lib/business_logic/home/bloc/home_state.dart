part of 'home_bloc.dart';

final class HomeState extends Equatable {
  HomeState(
      {required this.status,
      required this.properties,
      required this.selectedProperty});

  FetchPropertStatus status;
  List<PropertyModel> properties;
  PropertyModel selectedProperty;

  HomeState copyWith({
    FetchPropertStatus? status,
    List<PropertyModel>? properties,
    PropertyModel? selectedProperty,
  }) {
    return HomeState(
      status: status ?? this.status,
      properties: properties ?? this.properties,
      selectedProperty: selectedProperty ?? this.selectedProperty,
    );
  }

  @override
  List<Object> get props => [properties, selectedProperty];
}
