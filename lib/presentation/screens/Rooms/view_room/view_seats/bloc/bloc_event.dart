import 'package:equatable/equatable.dart';

abstract class SeatEvent extends Equatable {
  const SeatEvent();

  @override
  List<Object> get props => [];
}

class AddRoomEvent extends SeatEvent {
  final String userId;
  final String roomName;
  final String rows;
  final String columns;
  final List<String> seatStates;

  const AddRoomEvent(
      {required this.userId,
      required this.roomName,
      required this.rows,
      required this.columns,
      required this.seatStates});

  @override
  List<Object> get props => [userId, roomName, rows, columns, seatStates];
}

class FetchSeatsEvent extends SeatEvent {
 // final String userId;
  final String roomId;
  const FetchSeatsEvent({
    //required this.userId,
     required this.roomId});
  @override
  List<Object> get props => [roomId];
}
