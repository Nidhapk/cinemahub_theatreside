import 'package:equatable/equatable.dart';
import 'package:onlinebooking_theatreside/data/models/theatre_model/thatre_model.dart';

abstract class TheatreState extends Equatable {
  const TheatreState();

  @override
  List<Object?> get props => [];
}

class TheatreLoading extends TheatreState {}

class TheatreLoaded extends TheatreState {
  final TheatreModel theatreData;

  const TheatreLoaded(this.theatreData);

  @override
  List<Object?> get props => [theatreData];
}

class TheatreError extends TheatreState {
  final String message;

  const TheatreError(this.message);

  @override
  List<Object?> get props => [message];
}

class MutipleImageInitialState extends TheatreState {
  final List<String> images;
  const MutipleImageInitialState(this.images);
  @override
  List<Object?> get props => [images];
}

class MultipleImageselectedState extends TheatreState {
  final List<String> images;
  const MultipleImageselectedState(this.images);
  @override
  List<Object?> get props => [images];
}

class SavingImagesState extends TheatreState {
  const SavingImagesState();
}

class SavingImagesErrostate extends TheatreState {
  final String message;
  const SavingImagesErrostate(this.message);
}

class EditingAccountState extends TheatreState {}

class EditeAccountSuccessState extends TheatreState {}

class EditAccountErrorState extends TheatreState {
  final String error;
  const EditAccountErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class EditProfileImageSuccessState extends TheatreState {}

class EditProfileImageErrorState extends TheatreState{
  final String error;
  const EditProfileImageErrorState(this.error);
   @override
  List<Object?> get props => [error];
}
class EditLocationSuccessState extends TheatreState{

}
class EditLocationErrorState extends TheatreState{
  final String error;
  const EditLocationErrorState(this.error);
   @override
  List<Object?> get props => [error];
}
