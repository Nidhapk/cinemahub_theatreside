import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onlinebooking_theatreside/data/models/movie/movie_model.dart';


class MovieDatabaserepository {
  final CollectionReference movieCollection =
      FirebaseFirestore.instance.collection('movies');

        Future<List<MovieClass>> getAllMovies() async {
    try {
      final snapshot = await movieCollection.get() as  QuerySnapshot<Map<String, dynamic>>;

      if (snapshot.docs.isEmpty) {
        throw Exception("No movies found");
      }

      final List<MovieClass> movies = snapshot.docs.map((doc) {
        return MovieClass.fromJson(doc.data());
      }).toList();

      return movies;
    } on FirebaseException catch (_) {
     
      rethrow;
    }
  }

  Future<MovieClass> getMovieById(String movieId) async {
    try {
      final movies = await movieCollection.doc(movieId).get()as DocumentSnapshot<Map<String, dynamic>>;
      if (movies.exists) {
        return MovieClass.fromJson(movies.data()?? {});
      } else {
        throw Exception("Movie not found");
      }
    } on FirebaseException catch (_) {

      rethrow;
    }
  }

  
}
