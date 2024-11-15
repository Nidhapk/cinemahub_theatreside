import 'package:equatable/equatable.dart';
import 'package:onlinebooking_theatreside/data/models/shows/shows_model.dart';

class EditShowEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EditShowButtonOnclickedEvent extends EditShowEvent {
  final ShowModel show;
  
  EditShowButtonOnclickedEvent(this.show);
   @override
  List<Object> get props => [];

}
