import 'package:cloud_firestore/cloud_firestore.dart';

class MovieReviewModel {
  String userId;
  String movieId;
  String userName;
  int rating;
  String comment;

  DateTime dateTime;
  String userProfile;

  MovieReviewModel(
      {required this.userId,
      required this.userName,
      required this.rating,
      required this.comment,
      required this.dateTime,
      required this.movieId,
      required this.userProfile});

  // Convert a Review object to a map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'rating': rating,
      'comment': comment,
      'dateTime': dateTime,
      'movieId': movieId,
      'userProfile': userProfile,
    };
  }

  factory MovieReviewModel.fromJson(Map<String, dynamic> json) {
    return MovieReviewModel(
        userId: json['userId'] ?? '',
        userName: json['userName'] ?? '',
        rating: json['rating'] ?? '',
        comment: json['comment'] ?? '',
        dateTime: (json['dateTime'] ?? '' as Timestamp).toDate(),
        movieId: json['movieId'] ?? '',
        userProfile: json['userProfile'] ?? '');
  }
}
