import 'package:equatable/equatable.dart';

abstract class ShowEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAllShows extends ShowEvent {
  FetchAllShows();
  @override
  List<Object> get props => [];
}

class DeleteShowEvent extends ShowEvent {
  final String showId;
  DeleteShowEvent(this.showId);
  @override
  List<Object> get props => [showId];
}


