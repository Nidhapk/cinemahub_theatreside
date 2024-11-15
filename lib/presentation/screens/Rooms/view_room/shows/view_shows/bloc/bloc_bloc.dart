import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/repository/shows_repository.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/view_shows/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/view_shows/bloc/bloc_state.dart';

class ShowBloc extends Bloc<ShowEvent, ShowState> {
  ShowBloc() : super(const ShowsLoadingState()) {
    on<FetchAllShows>(fetchallShows);
    on<DeleteShowEvent>(cancelShow);
  }

  Future<void> cancelShow(
      DeleteShowEvent event, Emitter<ShowState> emit) async {
    try {
      await MovieShowsRepository().cancelShow(event.showId);
      emit(const ShowDeletedSuccessState());
    } catch (e) {
      emit(ShowDeletedeErrorState('Error : $e'));
    }
  }

  Future<void> fetchallShows(
      FetchAllShows event, Emitter<ShowState> emit) async {
    emit(const ShowsLoadingState());
    try {
      final shows = await MovieShowsRepository().getAllShows();
      emit(ShowsLoadedState(shows));
    } catch (e) {
      log('show error : $e');
      emit(ShowsLoadederrorState('Error : $e'));
    }
  }
}
