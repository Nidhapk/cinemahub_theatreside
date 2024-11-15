import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onlinebooking_theatreside/data/models/shows/shows_model.dart';

class MovieShowsRepository {
  final fireStoreCollection = FirebaseFirestore.instance.collection('Shows');
  String currentUser = FirebaseAuth.instance.currentUser!.uid;

  Future<void> addshows(ShowModel show) async {
    try {
      final docRef = await fireStoreCollection.add(show.toMap());
      String showId = docRef.id;
      docRef.update({'showId': showId});
    } catch (e) {
      log('$e');
    }
  }

  Future<List<ShowModel>> getAllShows() async {
    try {
      final snapshot = await fireStoreCollection.get();

      final List<ShowModel> shows = snapshot.docs.map((doc) {
        final data = doc.data(); // Explicit cast
        log('Document data: $data'); // Log the document data
        return ShowModel.fromMap(data);
      }).toList();

      return shows;
    } on FirebaseException catch (e) {
      log('Error fetching shows: $e');
      rethrow;
    }
  }

  Future<void> editshowdetails(String showId, ShowModel show) async {
    try {
      await fireStoreCollection.doc(showId).update(show.toMap());
    } on FirebaseException catch (e) {
      print('Error fetching movies: $e');
      rethrow;
    }
  }

  Future<void> cancelShow(String showId) async {
    try {
      await fireStoreCollection.doc(showId).delete();
    } on FirebaseException catch (e) {
      print('Error fetching movies: $e');
      rethrow;
    }
  }
}
