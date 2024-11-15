import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:onlinebooking_theatreside/data/models/theatre_model/thatre_model.dart';

class TheatreDatabaseRepository {
  final theatre = FirebaseFirestore.instance.collection('theatres');
  Future<void> addTheatreToFirestore(TheatreModel theatre) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        String userId = currentUser.uid;

        TheatreModel theatreDetails = TheatreModel(
          userId: userId, emailId: theatre.emailId,
          name: theatre.name,
          address: theatre.address,
          latLng: theatre.latLng, //phone: theatre.phone,
          profileImage: theatre.profileImage,
          images: theatre.images,
          phone: theatre.phone
        );

        await FirebaseFirestore.instance
            .collection('theatres')
            .doc(userId)
            .set(theatreDetails.toMap());
      } else {}
    } catch (_) {}
  }

  Future<List<String>> uploadImages(List<XFile>? selectedImages) async {
    if (selectedImages != null) {
      List<String> imageUrls = [];

      try {
        for (var image in selectedImages) {
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          Reference referenceDirectory =
              FirebaseStorage.instance.ref().child('theatre_images');
          Reference referenceImageToUpload = referenceDirectory.child(fileName);
          await referenceImageToUpload.putFile(File(image.path));
          imageUrls.add(await referenceImageToUpload.getDownloadURL());
        }
      } catch (_) {}
      return imageUrls;
    }
    return [''];
  }

  Future<String> uploadProfileImage(String? selectedImage) async {
    String imageUrl;
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference referenceDirectory =
          FirebaseStorage.instance.ref().child('theatre_profile');
      Reference referenceImageToUpload = referenceDirectory.child(fileName);
      await referenceImageToUpload.putFile(File(selectedImage!));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      return imageUrl;
    } catch (e) {
      log('peofile: error');
    }
    return '';
  }

  Future<void> editAccount(String name) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await theatre.doc(userId).update({
      'name': name,
    });
  }

  Future<void> editTheatreprofile(String imgUrl) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await theatre.doc(userId).update({
      'profileImage': imgUrl,
    });
  }

  Future<void> editTheatreimages(List<String> images) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await theatre.doc(userId).update({
      'images': images,
    });
  }

  Future<void> editLocation(
      {required String addess, required LatLng latlng}) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await theatre.doc(userId).update({
      'address': addess,
      'lat': latlng.latitude,
      'lng': latlng.longitude,
    });
  }
}
