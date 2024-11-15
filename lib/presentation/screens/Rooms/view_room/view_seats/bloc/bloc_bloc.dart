import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/repository/rooms_repository.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/view_seats/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/view_seats/bloc/bloc_states.dart';

class SeatBloc extends Bloc<SeatEvent, SeatState> {
  SeatBloc() : super(SeatInitial()) {
    on<FetchSeatsEvent>(onFetchSeatDeatailsEvent);
  }

  Future<void> onFetchSeatDeatailsEvent(
      FetchSeatsEvent event, Emitter<SeatState> emit) async {
    emit(
      SeatLoading(),
    );
    try {
      final rooms = await RoomsRepository().fetchseatDetailsDetails(event.roomId,);
      emit(
        SeatLoaded(rooms),
      );
    } catch (e) {
      emit(
        SeatLoadedError('Failed to fetch rooms: $e'),
      );
    }
  }
}
