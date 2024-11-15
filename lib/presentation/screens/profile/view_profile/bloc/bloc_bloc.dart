// theatre_bloc.dart
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onlinebooking_theatreside/data/models/theatre_model/thatre_model.dart';
import 'package:onlinebooking_theatreside/data/repository/theatre_database_repository.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/view_profile/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/view_profile/bloc/bloc_state.dart';

String currentUserId = FirebaseAuth.instance.currentUser?.email ?? '';

class TheatreBloc extends Bloc<TheatreEvent, TheatreState> {
  TheatreBloc() : super(TheatreLoading()) {
    on<FetchTheatreDetails>(_onFetchTheatreDetails);
    on<EditMultipleImagesEvent>(onEditMultipleImagesEvent);
    on<SaveImagesEvent>(saveImages);
    on<EditAccountEvent>(editAccountDetails);
    on<EditProfileEvent>(editProfileImage);
    on<EditLocationEvent>(editLocation);
  }

  Future<void> _onFetchTheatreDetails(
      FetchTheatreDetails event, Emitter<TheatreState> emit) async {
    emit(TheatreLoading());

    try {
      if (currentUserId.isEmpty) {
        emit(const TheatreError("User not logged in"));
        return;
      }
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('theatres')
          .where('emailId', isEqualTo: currentUserId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;
        log('doc ${doc.data()}');
        TheatreModel theatre = TheatreModel.fromMap(
          doc.data() as Map<String, dynamic>,
        );

        emit(
          TheatreLoaded(theatre),
        );
      } else {
        emit(
          const TheatreError("Theatre document not found for this user"),
        );
      }
    } catch (e) {
      emit(
        TheatreError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> onEditMultipleImagesEvent(
      EditMultipleImagesEvent event, Emitter<TheatreState> emit) async {
    final ImagePicker picker = ImagePicker();
    try {
      final List<XFile> pickedFiles = await picker.pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        List<String> newImageUrls =
            pickedFiles.map((file) => file.path).toList();
        List<String> allImages = [...newImageUrls];

        emit(
          MultipleImageselectedState(allImages),
        );
      }
    } catch (e) {
      emit(
        TheatreError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> saveImages(
      SaveImagesEvent event, Emitter<TheatreState> emit) async {
    emit(TheatreLoading());
    try {
      List<String> imageUrls = [];
      List<String> images = event.images;
      List<File> filesToUpload = [];
      ;

      // Separate URLs and local files
      for (var item in images) {
        if (item.startsWith('http')) {
          // If it's already a URL, add it to the list of URLs
          imageUrls.add(item);
        } else {
          // If it's a local file, prepare it for upload
          filesToUpload.add(File(item));
        }
      }
      for (var imageFile in filesToUpload) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference storageRef =
            FirebaseStorage.instance.ref().child('theatre_images/$fileName');

        // Upload the image to Firebase Storage
        UploadTask uploadTask = storageRef.putFile(imageFile);
        TaskSnapshot taskSnapshot = await uploadTask;

        // Get the download URL and add it to the list of URLs
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      }

      await TheatreDatabaseRepository().editTheatreimages(imageUrls);
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('theatres')
          .where('emailId', isEqualTo: currentUserId)
          .get();
      log('query: $querySnapshot');
      if (querySnapshot.docs.isNotEmpty) {
        log('empty');
        DocumentSnapshot doc = querySnapshot.docs.first;
        log('doc ${doc.data()}');
        TheatreModel theatre = TheatreModel.fromMap(
          doc.data() as Map<String, dynamic>,
        );
        log(' eeee ${TheatreModel.fromMap(doc.data() as Map<String, dynamic>)}');
        emit(
          TheatreLoaded(theatre),
        );
      } else {
        emit(
          const SavingImagesErrostate('Failed to update images'),
        );
      }
    } catch (e) {}
  }

  Future<void> editAccountDetails(
      EditAccountEvent event, Emitter<TheatreState> emit) async {
    emit(EditingAccountState());
    try {
      await TheatreDatabaseRepository().editAccount(event.name ?? '');
      emit(EditeAccountSuccessState());
    } catch (e) {
      emit(EditAccountErrorState('Error : $e'));
    }
  }

  Future<void> editProfileImage(
      EditProfileEvent event, Emitter<TheatreState> emit) async {
    emit(EditingAccountState());
    try {
      final imgurl = await TheatreDatabaseRepository()
          .uploadProfileImage(event.profileImage);
      await TheatreDatabaseRepository().editTheatreprofile(imgurl);
      emit(EditProfileImageSuccessState());
    } catch (e) {
      emit(EditProfileImageErrorState('error : $e'));
    }
  }

  Future<void> editLocation(
      EditLocationEvent event, Emitter<TheatreState> emit) async {
    try {
      await TheatreDatabaseRepository()
          .editLocation(addess: event.address!, latlng: event.latlng!);
      emit(EditLocationSuccessState());
    } catch (e) {
      emit(EditLocationErrorState('Error : $e'));
    }
  }
}
