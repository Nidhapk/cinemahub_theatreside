import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/repository/rooms_repository.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/room_home/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/room_home/bloc/bloc_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc() : super(RoomInitial()) {
    on<AddRoomEvent>(_onAddRoomEvent);
    on<FetchRoomsEvent>(onFetchRoomsEvent);
    on<DeleteRoomEvent>(ondeleteRoom);
    on<EditRoomEvent>(onEditRoom);
  }

  Future<void> _onAddRoomEvent(
      AddRoomEvent event, Emitter<RoomState> emit) async {
    emit(RoomAdding());
    try {
      await RoomsRepository().addRooms(event.room);

      emit(
        RoomAddedSuccess(),
      );
    } catch (e) {
      emit(
        RoomAddedError('Failed to add room: $e'),
      );
    }
  }

  Future<void> onFetchRoomsEvent(
      FetchRoomsEvent event, Emitter<RoomState> emit) async {
    emit(
      RoomLoading(),
    );
    try {
      final rooms = await RoomsRepository().fetchRooms();
      emit(
        RoomLoaded(rooms),
      );
    } catch (e) {
      emit(
        RoomAddedError('Failed to fetch rooms: $e'),
      );
    }
  }

  Future<void> ondeleteRoom(
      DeleteRoomEvent event, Emitter<RoomState> emit) async {
    emit(RoomLoading());
    try {
      await RoomsRepository().deleteRoom(event.roomId);
      emit(const RoomDeletedState());
    } catch (e) {
      emit(RoomDeletedErrorState('Error: $e'));
    }
  }

  Future<void> onEditRoom(EditRoomEvent event, Emitter<RoomState> emit) async {
    emit(RoomLoading());
    try {
      await RoomsRepository().editRoomName(event.roomId, event.roomName);
      emit(const RoomEditedSuccessState());
    } catch (e) {
      emit(RoomEditedErrorState('Error: $e'));
    }
  }
}
