import 'package:onlinebooking_theatreside/data/models/movie/cast_member.dart';
import 'package:onlinebooking_theatreside/data/models/movie/movie_review_model.dart';

class MovieClass {
  String? movieId;
  bool blocked;
  String trailerLink;
  String movieName;
  String certificate;
  List<String> languages;
  List<String> genres;
  String releaseDate;
  String duration;
  String description;
  List<CastMember> castMembers;
  String posterImage;
  String backdropImage;
  List<MovieReviewModel> review;

  MovieClass(
      {this.movieId,
      required this.blocked,
      required this.trailerLink,
      required this.movieName,
      required this.certificate,
      required this.languages,
      required this.genres,
      required this.releaseDate,
      required this.duration,
      required this.description,
      required this.castMembers,
      required this.posterImage,
      required this.backdropImage,
      required this.review});

  Map<String, dynamic> toMap() {
    return {
      'blocked': blocked,
      'trailerLink': trailerLink,
      'movieName': movieName,
      'certificate': certificate,
      'languages': languages,
      'genres': genres,
      'releaseDate': releaseDate,
      'duration': duration,
      'description': description,
      'castMembers': castMembers.map((cast) => cast.toMap()).toList(),
      'posterImage': posterImage,
      'backdropImage': backdropImage,
      'reviews': review.map((review) => review.toMap()).toList(),
    };
  }

  factory MovieClass.fromJson(Map<String, dynamic> data) {
    return MovieClass(
      movieId: data['movieId'] ?? '',
      blocked: data['blocked'] ?? false,
      trailerLink: data['trailerLink'] ?? '',
      movieName: data['movieName'] ?? '',
      certificate: data['certificate'] ?? '',
      languages: List<String>.from(data['languages'] ?? []),
      genres: List<String>.from(data['genres'] ?? []),
      releaseDate: data['releaseDate'] ?? '',
      duration: data['duration'] ?? 0,
      description: data['description'] ?? '',
      castMembers: (data['castMembers'] as List)
          .map((cast) => CastMember.fromMap(cast as Map<String, dynamic>))
          .toList(),
      posterImage: data['posterImage'] ?? '',
      backdropImage: data['backdropImage'] ?? '',
      review: (data['reviews'] as List)
          .map((review) =>
              MovieReviewModel.fromJson(review as Map<String, dynamic>))
          .toList(),
    );
  }
}
