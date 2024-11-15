import 'package:latlong2/latlong.dart';

abstract class LocationEvent {}

class OpenMapEvent extends LocationEvent {}

class LocationSelectedEvent extends LocationEvent {
  final LatLng selectedLocation;

  LocationSelectedEvent(this.selectedLocation);
}