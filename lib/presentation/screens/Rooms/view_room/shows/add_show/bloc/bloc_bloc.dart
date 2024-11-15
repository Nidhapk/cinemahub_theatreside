import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/repository/movie_repository.dart';
import 'package:onlinebooking_theatreside/data/repository/shows_repository.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/add_show/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/add_show/bloc/bloc_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieDatabaserepository movieRepository;

  MovieBloc(this.movieRepository) : super(MovieInitial()) {
    on<FetchAllMoviesEvent>(_onFetchAllMovies);
    on<SelectMovieEvent>(selectedMovie);
    on<AddShowEvent>(addShow);
    // on<FetchMovieEvent>(_onFetchMovie);
    // on<BlockMovieEvent>(deleteMovie);
  }

  Future<void> _onFetchAllMovies(
    FetchAllMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieLoading());
    try {
      final movies = await movieRepository.getAllMovies();
      emit(
        MoviesLoaded(movies),
      );
    } catch (e) {
      emit(
        MovieError("Failed to fetch movies: $e"),
      );
    }
  }

  Future<void> selectedMovie(
      SelectMovieEvent event, Emitter<MovieState> emit) async {
    try {
      emit(MovieSelectedState(event.movie));
    } catch (_) {}
  }

  Future<void> addShow(AddShowEvent event, Emitter<MovieState> emit) async {
    emit(ShowAddingState());
    try {
      await MovieShowsRepository().addshows(event.show);
      emit(const ShowAddedSuccess());
    } catch (e) {
      emit(ShowAddedFailureState('Error : $e'));
    }
  }
}
