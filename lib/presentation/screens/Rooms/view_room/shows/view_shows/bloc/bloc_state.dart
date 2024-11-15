import 'package:equatable/equatable.dart';
import 'package:onlinebooking_theatreside/data/models/shows/shows_model.dart';

abstract class ShowState extends Equatable {
  const ShowState();
  @override
  List<Object> get props => [];
}

class ShowsLoadingState extends ShowState {
  const ShowsLoadingState();
  @override
  List<Object> get props => [];
}

class ShowsLoadedState extends ShowState {
  final List<ShowModel> shows;
  const ShowsLoadedState(this.shows);
  @override
  List<Object> get props => [shows];
}

class ShowsLoadederrorState extends ShowState {
  final String error;
  const ShowsLoadederrorState(this.error);
  @override
  List<Object> get props => [error];
}

class ShowDeletedSuccessState extends ShowState {
  final String message;
  const ShowDeletedSuccessState(
      {this.message = 'Show has been deleted successfully'});
  @override
  List<Object> get props => [message];
}

class ShowDeletedeErrorState extends ShowState {
  final String error;
 const  ShowDeletedeErrorState(this.error);
   @override
  List<Object> get props => [error];
}
