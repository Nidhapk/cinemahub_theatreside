import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/repository/theatre_database_repository.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/add_profile/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/add_profile/bloc/bloc_state.dart';

class AddProfileBloc extends Bloc<AddProfileEvent, AddProfilestate> {
  AddProfileBloc() : super(AddingProfileInitialState()) {
    on<AddProfileOnClickedEvent>(addProfile);
  }
}

Future<void> addProfile(
    AddProfileOnClickedEvent event, Emitter<AddProfilestate> emit) async {
  emit(const AddingProfileState());
  try {
    await TheatreDatabaseRepository().addTheatreToFirestore(event.theatre);
    emit(const AddProfileSuccessState());
  } catch (e) {
    emit(AddProfileFailureState('Error: $e'));
  }
}