import 'package:equatable/equatable.dart';
import 'package:onlinebooking_theatreside/data/models/rooms/rooms_model.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();

  @override
  List<Object> get props => [];
}

class AddRoomEvent extends RoomEvent {
  final RoomModel room;

  const AddRoomEvent({required this.room});

  @override
  List<Object> get props => [room];
}

class FetchRoomsEvent extends RoomEvent {}

class DeleteRoomEvent extends RoomEvent {
  final String roomId;
  const DeleteRoomEvent(this.roomId);
  @override
  List<Object> get props => [roomId];
}

class EditRoomEvent extends RoomEvent {
  final String roomId;
  final String roomName;
 // final RoomModel room;
  const EditRoomEvent({required this.roomId, required this.roomName});
  @override
  List<Object> get props => [roomId, roomName];
}
