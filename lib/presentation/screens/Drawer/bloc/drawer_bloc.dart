import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Drawer/bloc/drawer_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Drawer/bloc/drawer_state.dart';


class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(DashboardState()) {
    on<NavigateToDashboardEvent>((event, emit) => emit(DashboardState()));
    on<NavigateToRoomsEvent>((event, emit) => emit(RoomsState()));
    on<NavigateToBookingsEvent>((event, emit) => emit(BookingsState()));
    on<NavigateToCustomersEvent>((event, emit) => emit(CustomersState()));
    on<NavigateToProfileEvent>((event, emit) => emit(ProfileState()));
  }
}
