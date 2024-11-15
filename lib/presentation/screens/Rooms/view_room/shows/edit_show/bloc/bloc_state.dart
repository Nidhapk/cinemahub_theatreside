import 'package:equatable/equatable.dart';

class EditShowState extends Equatable {
  @override
  List<Object> get props => [];
}

class ShowEditingState extends EditShowState {
  ShowEditingState();
  @override
  List<Object> get props => [];
}

class ShowEditedSuccessState extends EditShowState {
  final String message;
  ShowEditedSuccessState(
      {this.message = 'New show has been added successfully'});
  @override
  List<Object> get props => [message];
}

class ShowEditedErrorState extends EditShowState {
   final String error;
   ShowEditedErrorState(this.error);
  @override
  List<Object> get props => [error];
}
