import 'package:equatable/equatable.dart';
import 'package:onlinebooking_theatreside/data/models/movie/movie_model.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final MovieClass movie;

  const MovieLoaded(this.movie);

  @override
  List<Object> get props => [movie];
}

class MoviesLoaded extends MovieState {
  final List<MovieClass> movies;

  const MoviesLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieError extends MovieState {
  final String message;

  const MovieError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieSelectedState extends MovieState {
  final MovieClass movie;
  const  MovieSelectedState(this.movie);
   @override
  List<Object> get props => [movie];
}
class ShowAddingState extends MovieState{

}
class ShowAddedSuccess extends MovieState {
  final String message; // Optional message or data indicating success

  const ShowAddedSuccess([this.message = "Show added successfully."]); // Default message

  @override
  List<Object> get props => [message];
}

class ShowAddedFailureState extends MovieState {
  final String error; // Include an error message to indicate failure

  const ShowAddedFailureState(this.error);

  @override
  List<Object> get props => [error];
}
