import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:otonomus/data/enums/enums.dart';
import 'package:otonomus/data/models/property_model.dart';
import 'package:otonomus/data/repository/property_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
    PropertyRepository propertyRepository,
  )   : _propertyRepository = propertyRepository,
        super(HomeState(
            status: FetchPropertStatus.loading,
            properties: [],
            selectedProperty: PropertyModel.defaultProperty)) {
    on<GetAllProperties>(_getAllProperties);
    on<SelectedPropertyChanged>(_onSelectedPropertyChanged);
    on<SelectedPageChanged>(_onSelectedPageChanged);
  }

  final PropertyRepository _propertyRepository;

  Future<void> _getAllProperties(
    HomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    List<PropertyModel> properties =
        await _propertyRepository.getAllProperties();
    if (properties.isNotEmpty) {
      print('Not empty');
      emit(HomeState(
          status: FetchPropertStatus.success,
          properties: properties,
          selectedProperty: properties.first));
      print('${state.status}, ${state.properties}, ${state.selectedProperty}');
    } else {
      emit(HomeState(
          status: FetchPropertStatus.failure,
          properties: [],
          selectedProperty: PropertyModel.defaultProperty));
    }
  }

  void _onSelectedPropertyChanged(
    SelectedPropertyChanged event,
    Emitter<HomeState> emit,
  ) {
    emit(
      state.copyWith(
        selectedProperty: event.selectedProperty,
      ),
    );
  }

  void _onSelectedPageChanged(
      SelectedPageChanged event, Emitter<HomeState> emit) {
    event.availableSpace.currentIndex = event.newIndex;
  }
}
