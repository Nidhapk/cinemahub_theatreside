import 'package:equatable/equatable.dart';

abstract class ShowEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAllShows extends ShowEvent {
 final String roomId;
  FetchAllShows(this.roomId);
  @override
  List<Object> get props => [roomId];
}

class DeleteShowEvent extends ShowEvent {
  final String showId;
  DeleteShowEvent(this.showId);
  @override
  List<Object> get props => [showId];
}
