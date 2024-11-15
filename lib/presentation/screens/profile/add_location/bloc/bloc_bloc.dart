import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/add_location/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/add_location/bloc/bloc_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<OpenMapEvent>(onMapOpened);
    on<LocationSelectedEvent>(_onLocationSelected);
  }

  void onMapOpened(OpenMapEvent event, Emitter<LocationState> emit) async {
    // Trigger map loading process
    emit(MapLoadingState());
    // Simulate map loading
    await Future.delayed(const Duration(seconds: 1), () {
      emit(MapLoadedState());
    });
  }

  Future<void> _onLocationSelected(
      LocationSelectedEvent event, Emitter<LocationState> emit) async {
    emit(LocationLoading());
    try {
      // Fetch address from selected coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        event.selectedLocation.latitude,
        event.selectedLocation.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String address =
            "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";
        emit(LocationLoaded(address,LatLng(event.selectedLocation.latitude,
        event.selectedLocation.longitude,)));
      }
    } catch (e) {
      emit(LocationError("Failed to fetch address"));
    }
  }
}
