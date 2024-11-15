import 'package:equatable/equatable.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/add_seats/ui/add_seats.dart';

abstract class EditSeatsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchEditSeatsEvent extends EditSeatsEvent {
  final String roomId;

  FetchEditSeatsEvent(this.roomId);

  @override
  List<Object> get props => [roomId];
}

class UpdateSeatStateEvent extends EditSeatsEvent {
  final int index;
  final SeatStates seatState;

  UpdateSeatStateEvent(this.index, this.seatState);

  @override
  List<Object> get props => [index, seatState];
}

class UpdateGridDimensionsEvent extends EditSeatsEvent {
  final int rows;
  final int columns;

   UpdateGridDimensionsEvent(this.rows, this.columns);

  @override
  List<Object> get props => [rows, columns];
}
// Event for single tap
class UpdateSeatStateOnTapEvent extends EditSeatsEvent {
  final int index;

  UpdateSeatStateOnTapEvent(this.index);

  @override
  List<Object> get props => [index];
}

// Event for double tap
class UpdateSeatStateOnDoubleTapEvent extends EditSeatsEvent {
  final int index;

  UpdateSeatStateOnDoubleTapEvent(this.index);

  @override
  List<Object> get props => [index];
}
