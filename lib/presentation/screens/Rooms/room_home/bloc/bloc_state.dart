import 'package:equatable/equatable.dart';
import 'package:onlinebooking_theatreside/data/models/rooms/rooms_model.dart';

abstract class RoomState extends Equatable {
  const RoomState();

  @override
  List<Object> get props => [];
}

class RoomInitial extends RoomState {}

class RoomAdding extends RoomState {}

class RoomAddedSuccess extends RoomState {}

class RoomLoading extends RoomState {}

class RoomLoaded extends RoomState {
  final List<RoomModel> rooms;

  const RoomLoaded(this.rooms);

  @override
  List<Object> get props => [rooms];
}

class RoomAddedError extends RoomState {
  final String error;

  const RoomAddedError(this.error);

  @override
  List<Object> get props => [error];
}

class RoomDeletedState extends RoomState {
  const RoomDeletedState();
   @override
  List<Object> get props => [];
}
class RoomDeletedErrorState extends RoomState {
  final String error;
  const RoomDeletedErrorState(this.error);
   @override
  List<Object> get props => [error];
}class RoomEditedErrorState extends RoomState {
  final String error;
  const RoomEditedErrorState(this.error);
   @override
  List<Object> get props => [error];
}
class RoomEditedSuccessState extends RoomState {
  const RoomEditedSuccessState();
   @override
  List<Object> get props => [];
}