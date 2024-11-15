import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String bookingId;
  final String theatreId;
  final String movieName;
  final String moviePoster;
  final String theatreName;
  final String userId;
  final String userEmail;
  final String screenName;
  final List<String> seatNumbers;
  final double totalAmount;
  final DateTime showDate;
  final String showTime;
  final Timestamp timeStamp;

  BookingModel(
      {required this.bookingId,
      required this.theatreId,
      required this.movieName,
      required this.moviePoster,
      required this.theatreName,
      required this.userId,
      required this.userEmail,
      required this.screenName,
      required this.seatNumbers,
      required this.totalAmount,
      required this.showDate,
      required this.showTime,
      required this.timeStamp});

  // Convert BookingModel to Map (for Firebase storage)
  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'theatreId':theatreId,
      'movieName': movieName,
      'moviePoster': moviePoster,
      'theatreName': theatreName,
      'userId': userId,
      'userEmail': userEmail,
      'screenName': screenName,
      'seatNumbers': seatNumbers,
      'totalAmount': totalAmount,
      'showDate': showDate.toIso8601String(), // Storing date as ISO8601 string
      'showTime': showTime,
      'timeStamp': timeStamp,
    };
  }

  // Create a BookingModel from Map (retrieving from Firebase)
  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingId: json['bookingId'] ?? '',
      theatreId: json['theatreId']??'',
      movieName: json['movieName'], moviePoster: json['moviePoster'] ?? '',
      theatreName: json['theatreName'] ?? '',
      userId: json['userId'] ?? '',
      userEmail: json['userEmail'] ?? '',
      screenName: json['screenName'] ?? '',
      seatNumbers: List<String>.from(json['seatNumbers'] ?? []),
      totalAmount: json['totalAmount'].toDouble(),
      showDate: DateTime.parse(
          json['showDate'] ?? ''), // Parsing the stored ISO string
      showTime: json['showTime'] ?? '',
      timeStamp: json['timeStamp'] ?? '',
    );
  }
}
