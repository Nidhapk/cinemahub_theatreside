import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class MapLoadingState extends LocationState {}

class MapLoadedState extends LocationState {}

class MapError extends LocationState {
  final String errorMessage;

  const MapError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class LocationLoaded extends LocationState {
  final String address;
  final LatLng latlng;

  const LocationLoaded(this.address,this.latlng);

  @override
  List<Object?> get props => [address];
}

class LocationError extends LocationState {
  final String errorMessage;

  const LocationError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
