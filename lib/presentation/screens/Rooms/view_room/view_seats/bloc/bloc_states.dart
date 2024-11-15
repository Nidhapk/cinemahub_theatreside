import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class SeatState extends Equatable {
  const SeatState();

  @override
  List<Object> get props => [];
}

class SeatInitial extends SeatState {}

class SeatAdding extends SeatState {}

class SeatAddedSuccess extends SeatState {}
class SeatLoading extends SeatState {}

class SeatLoaded extends SeatState {
  final DocumentSnapshot<Object?> rooms;

  const SeatLoaded(this.rooms);

  @override
  List<Object> get props => [rooms];
}

class SeatLoadedError extends SeatState {
  final String error;

 const SeatLoadedError(this.error);

  @override
  List<Object> get props => [error];
}
