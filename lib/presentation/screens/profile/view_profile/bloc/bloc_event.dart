// theatre_event.dart
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class TheatreEvent extends Equatable {
  const TheatreEvent();

  @override
  List<Object?> get props => [];
}

class FetchTheatreDetails extends TheatreEvent {
//  final String documentId; // ID of the document to fetch

  const FetchTheatreDetails();

  @override
  List<Object?> get props => [];
}

class EditMultipleImagesEvent extends TheatreEvent {
  const EditMultipleImagesEvent();
  @override
  List<Object?> get props => [];
}

class SaveImagesEvent extends TheatreEvent {
  final List<String> images;
  const SaveImagesEvent(this.images);
  @override
  List<Object?> get props => [images];
}

class EditAccountEvent extends TheatreEvent {
  final String? name;
  final String? phone;
  const EditAccountEvent({this.name, this.phone});
  @override
  List<Object?> get props => [name,phone];
}

class EditAddressEvent extends TheatreEvent {}

class EditProfileEvent extends TheatreEvent {
  final String profileImage;
  const EditProfileEvent(this.profileImage);
  @override
  List<Object?> get props => [];
}

class EditLocationEvent extends TheatreEvent {
  final LatLng? latlng;
  final String? address;
  const EditLocationEvent({this.latlng, this.address});
}
