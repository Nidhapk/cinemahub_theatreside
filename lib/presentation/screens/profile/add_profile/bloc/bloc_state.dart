import 'package:equatable/equatable.dart';

abstract class AddProfilestate extends Equatable {
  const AddProfilestate();
  @override
  List<Object> get props => [];
}
class AddingProfileInitialState extends AddProfilestate{
  
}
class AddingProfileState extends AddProfilestate {
  const AddingProfileState();
}

class AddProfileSuccessState extends AddProfilestate {
  final String message;
  const AddProfileSuccessState(
      {this.message = 'Buisiness profile created successfully'});
}

class AddProfileFailureState extends AddProfilestate {
  final String error;
  const AddProfileFailureState(this.error);
  @override
  List<Object> get props => [error];
}
