import 'package:onlinebooking_theatreside/data/models/movie/movie_model.dart';
import 'package:onlinebooking_theatreside/data/models/rooms/rooms_model.dart';
import 'package:onlinebooking_theatreside/data/models/theatre_model/thatre_model.dart';

class ShowModel {
  final String showId;
  final String movieName;
  final MovieClass movie; // MovieClass object
  final String roomId;
  final DateTime date;
  final String time;
  final String language;
  final double ticketPrice;
  final String userId;
  final String poster;
  final RoomModel room;
  final TheatreModel theatre;

  ShowModel(
      {required this.showId,
      required this.movieName,
      required this.movie,
      required this.roomId,
      required this.date,
      required this.time,
      required this.language,
      required this.ticketPrice,
      required this.userId,
      required this.poster,
      required this.room,
      required this.theatre});

  // Convert a ShowModel instance to a map (Firestore)
  Map<String, dynamic> toMap() {
    return {
      'showId': showId,
      'movieName': movieName,
      'movie': movie.toMap(), // Convert MovieClass to a map
      'roomId': roomId,
      'date': date.toIso8601String(), // Convert DateTime to ISO format
      'time': time,
      'language': language,
      'ticketPrice': ticketPrice,
      'userId': userId, 'poster': poster,
      'room': room.toJson(), 'theatre': theatre.toMap()
    };
  }

  // Create a ShowModel instance from a map
  factory ShowModel.fromMap(Map<String, dynamic> json) {
    return ShowModel(
      showId: json['showId'] ?? '', // Handle missing or null values
      movieName: json['movieName'] ?? '',
      movie: MovieClass.fromJson(json['movie'] ), // Convert JSON to MovieClass
      roomId: json['roomId'] ?? '',
      date:
          DateTime.tryParse(json['date'] ?? DateTime.now().toIso8601String()) ??
              DateTime.now(), // Handle date parsing
      time: json['time'] ?? '',
      language: json['language'] ?? '',
      ticketPrice: (json['ticketPrice'] ?? 0).toDouble(),
      userId: json['userId'] ?? '',
      poster: json['poster'],
      room: RoomModel.fromJson(
        json['room'],
      ),
      theatre: TheatreModel.fromMap(
        json['theatre'],
      ),
    );
  }
}
