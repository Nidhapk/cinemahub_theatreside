import 'package:equatable/equatable.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/add_seats/ui/add_seats.dart';

abstract class EditSeatsState extends Equatable {
  @override
  List<Object> get props => [];
}

class EditSeatsInitial extends EditSeatsState {}

class EditSeatsLoading extends EditSeatsState {}

class EditSeatsLoaded extends EditSeatsState {
  final int rows;
  final int columns;
  final List<SeatStates> seatStates;

  EditSeatsLoaded({required this.rows, required this.columns, required this.seatStates});

  @override
  List<Object> get props => [rows, columns, seatStates];
}

class EditSeatsError extends EditSeatsState {
  final String message;

  EditSeatsError(this.message);

  @override
  List<Object> get props => [message];
}
