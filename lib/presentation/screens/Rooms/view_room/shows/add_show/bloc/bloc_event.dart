import 'package:equatable/equatable.dart';
import 'package:onlinebooking_theatreside/data/models/movie/movie_model.dart';
import 'package:onlinebooking_theatreside/data/models/shows/shows_model.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
  @override
  List<Object> get props => [];
}

class FetchMovieEvent extends MovieEvent {
  final String movieId;

  const FetchMovieEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class FetchAllMoviesEvent extends MovieEvent {}

class SelectMovieEvent extends MovieEvent {
  final MovieClass movie;
  const SelectMovieEvent(this.movie);
  @override
  List<Object> get props => [movie];
}

class ToggleMovieSelectionEvent extends MovieEvent {
  final MovieClass movie;
  const ToggleMovieSelectionEvent(this.movie);

  @override
  List<Object> get props => [movie];
}

class AddShowEvent extends MovieEvent {
  final ShowModel show;
  const AddShowEvent(this.show);
   @override
  List<Object> get props => [show];
}
