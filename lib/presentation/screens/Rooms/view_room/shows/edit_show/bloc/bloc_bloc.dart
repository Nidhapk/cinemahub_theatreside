import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/repository/shows_repository.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/edit_show/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/edit_show/bloc/bloc_state.dart';

class EditShowBloc extends Bloc<EditShowEvent, EditShowState> {
  EditShowBloc() : super(ShowEditingState()) {
    on<EditShowButtonOnclickedEvent>(editshow);
  }
}

Future<void> editshow(
    EditShowButtonOnclickedEvent event, Emitter<EditShowState> emit) async {
  emit(ShowEditingState());
  try {
    await MovieShowsRepository().editshowdetails(event.show.showId, event.show);
    emit(ShowEditedSuccessState());
  } catch (e) {
    emit(ShowEditedErrorState('error : $e'));
  }
}
