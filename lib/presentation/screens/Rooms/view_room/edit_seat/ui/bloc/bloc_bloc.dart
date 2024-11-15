import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/models/rooms/rooms_model.dart';
import 'package:onlinebooking_theatreside/data/repository/rooms_repository.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/add_seats/ui/add_seats.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/edit_seat/ui/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/edit_seat/ui/bloc/bloc_state.dart';

class EditSeatBloc extends Bloc<EditSeatsEvent, EditSeatsState> {
  final RoomsRepository roomsRepository;

  EditSeatBloc(this.roomsRepository) : super(EditSeatsInitial()) {
    on<FetchEditSeatsEvent>(_onFetchSeats);
    on<UpdateSeatStateEvent>(_onUpdateSeatState);
    on<UpdateGridDimensionsEvent>(_onUpdateGridDimensions);
    on<UpdateSeatStateOnTapEvent>(_onUpdateSeatStateOnTap);
    on<UpdateSeatStateOnDoubleTapEvent>(_onUpdateSeatStateOnDoubleTap);
  }

  Future<void> _onFetchSeats(
      FetchEditSeatsEvent event, Emitter<EditSeatsState> emit) async {
    try {
      emit(EditSeatsLoading());

      final roomSnapShot =
          await roomsRepository.fetchseatDetailsDetails(event.roomId);

      if (roomSnapShot.exists) {
        Map<String, dynamic> roomData =
            roomSnapShot.data() as Map<String, dynamic>;
        final roomModel = RoomModel.fromJson(roomData);
        final seatstates =
            convertStringsToSeatStates(roomModel.seatStates ?? []);
        log('$seatstates');
        emit(EditSeatsLoaded(
          rows: roomModel.rows ?? 0,
          columns: roomModel.columns ?? 0,
          seatStates: seatstates,
        ));
      } else {
        emit(EditSeatsError('Room not found'));
      }
    } catch (e) {
      emit(EditSeatsError('Failed to load seats'));
    }
  }

  void _onUpdateSeatState(
      UpdateSeatStateEvent event, Emitter<EditSeatsState> emit) {
    if (state is EditSeatsLoaded) {
      final currentState = state as EditSeatsLoaded;
      final updatedSeats = List<SeatStates>.from(currentState.seatStates);

      updatedSeats[event.index] = event.seatState;

      emit(EditSeatsLoaded(
        rows: currentState.rows,
        columns: currentState.columns,
        seatStates: updatedSeats,
      ));
    }
  }

  Future<void> _onUpdateGridDimensions(
    UpdateGridDimensionsEvent event,
    Emitter<EditSeatsState> emit,
  ) async {
    if (state is EditSeatsLoaded) {
      final currentState = state as EditSeatsLoaded;

      final newSeatCount = event.rows * event.columns;
      final currentSeatStates = List<SeatStates>.from(currentState.seatStates);

      List<SeatStates> updatedSeatStates;

      if (newSeatCount > currentSeatStates.length) {
        updatedSeatStates = List<SeatStates>.from(currentSeatStates)
          ..addAll(
            List.filled(
                newSeatCount - currentSeatStates.length, SeatStates.unselected),
          );
      } else {
        updatedSeatStates = currentSeatStates.take(newSeatCount).toList();
      }

      emit(
        EditSeatsLoaded(
          rows: event.rows,
          columns: event.columns,
          seatStates: updatedSeatStates,
        ),
      );
    } else {
      final newSeatCount = event.rows * event.columns;
      List<SeatStates> updatedSeatStates = List.filled(
        newSeatCount,
        SeatStates.unselected,
      );

      emit(
        EditSeatsLoaded(
          rows: event.rows,
          columns: event.columns,
          seatStates: updatedSeatStates,
        ),
      );
    }
  }

  List<SeatStates> convertStringsToSeatStates(List<String> seatStates) {
    return seatStates.map((seatState) {
      switch (seatState) {
        case 'unselected':
          return SeatStates.unselected;
        case 'selected':
          return SeatStates.selected;
        case 'empty':
          return SeatStates.empty;
        case 'unavailable':
          return SeatStates.unavailable;
        default:
          return SeatStates.unselected;
      }
    }).toList();
  }

  Future<void> _onUpdateSeatStateOnTap(
    UpdateSeatStateOnTapEvent event,
    Emitter<EditSeatsState> emit,
  ) async {
    if (state is EditSeatsLoaded) {
      final currentState = state as EditSeatsLoaded;
      final updatedSeatStates = List<SeatStates>.from(currentState.seatStates);

      updatedSeatStates[event.index] = SeatStates.unavailable;

      emit(
        EditSeatsLoaded(
          rows: currentState.rows,
          columns: currentState.columns,
          seatStates: updatedSeatStates,
        ),
      );
    }
  }

  Future<void> _onUpdateSeatStateOnDoubleTap(
    UpdateSeatStateOnDoubleTapEvent event,
    Emitter<EditSeatsState> emit,
  ) async {
    if (state is EditSeatsLoaded) {
      final currentState = state as EditSeatsLoaded;
      final updatedSeatStates = List<SeatStates>.from(currentState.seatStates);

      updatedSeatStates[event.index] = SeatStates.empty;

      emit(
        EditSeatsLoaded(
          rows: currentState.rows,
          columns: currentState.columns,
          seatStates: updatedSeatStates,
        ),
      );
    }
  }
}

List<SeatStates> convertSeatStates(List<Object>? seatStatesList) {
  if (seatStatesList == null) return [];

  return seatStatesList.map((e) {
    switch (e.toString()) {
      case 'unselected':
        return SeatStates.unselected;
      case 'selected':
        return SeatStates.selected;
      case 'empty':
        return SeatStates.empty;
      case 'unavailable':
        return SeatStates.unavailable;
      default:
        throw Exception('Unknown seat state: $e');
    }
  }).toList();
}
