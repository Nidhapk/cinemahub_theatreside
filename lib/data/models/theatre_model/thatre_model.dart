import 'package:latlong2/latlong.dart';

class TheatreModel {
  String userId;
  String emailId; // User ID of the theatre owner
  String name; // Name of the theatre
  String address; // Address of the theatre
  LatLng latLng;
String phone; // Latitude and longitude of the theatre (using latlong2)
  String profileImage; // Profile image of the theatre
  List<String> images; // List of other images of the theatre
  // Landmark near the theatre

  TheatreModel({
    required this.userId,
    required this.emailId,
    required this.name,
    required this.address,
    required this.latLng,
    required this.phone,
    required this.profileImage,
    required this.images,
  
  });

  // Factory method to create a TheatreModel from a map (useful when retrieving from Firestore)
  factory TheatreModel.fromMap(Map<String, dynamic> map) {
    return TheatreModel(
      userId: map['userId'] as String,
      emailId: map['emailId'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      latLng: LatLng(map['lat'] as double, map['lng'] as double),
      phone: map['phone'] as String,
      profileImage: map['profileImage'] as String,
      images: List<String>.from(map['images']),
      //landmark: map['landmark'] as String,
    );
  }

  // Method to convert TheatreModel to a map (useful for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'emailId': emailId,
      'name': name,
      'address': address,
      'lat': latLng.latitude,
      'lng': latLng.longitude,
      'phone':phone,
      'profileImage': profileImage,
      'images': images,
     // 'landmark': landmark,
    };
  }
}
