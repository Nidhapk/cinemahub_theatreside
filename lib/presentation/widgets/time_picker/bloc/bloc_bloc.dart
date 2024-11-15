import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/time_picker/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/time_picker/bloc/bloc_state.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  TimeBloc() : super(TimeInitial()) {
    on<TimeSelected>(
      (event, emit) {
        emit(
          TimeLoaded(event.selectedTime),
        );
      },
    );
  }
}
