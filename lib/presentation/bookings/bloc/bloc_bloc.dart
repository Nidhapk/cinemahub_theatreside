import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/repository/bookings_repository.dart';
import 'package:onlinebooking_theatreside/presentation/bookings/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/bookings/bloc/bloc_state.dart';

class BookingBloc extends Bloc<BookingEvents, BookingStates> {
  BookingBloc() : super(const BookingsLoadingState()) {
    on<FetchAllBookingsEvent>(fetchBookings);
  }

  Future<void> fetchBookings(
      FetchAllBookingsEvent event, Emitter<BookingStates> emit) async {
    try {
      final bookings = await BookingsRepository().fetchBookingsByTheatreId();
      emit(
        BookingsLoadedState(
          bookingModel: bookings,
        ),
      );
    } catch (e) {
      emit(
        BookingsLoadedErrorState(error: 'Errror:$e'),
      );
    }
  }
}
