import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/view_profile/ui/profile_screen.dart';
import 'package:onlinebooking_theatreside/presentation/bookings/ui/bokings_screen.dart';
import 'package:onlinebooking_theatreside/presentation/screens/customers/customers_screen.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/dashboard_screen.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/room_home/rooms_screen.dart';

abstract class HomeScreenState extends Equatable {
  final Widget page;

  const HomeScreenState(this.page);

  @override
  List<Object> get props => [page];
}

class DashboardState extends HomeScreenState {
  DashboardState() : super(dashBoardScreen());
}

class RoomsState extends HomeScreenState {
  RoomsState() : super(RoomsScreen());
}

class BookingsState extends HomeScreenState {
  const BookingsState()
      : super(const BookingScreen()); // Replace with BookingsScreen
}

class CustomersState extends HomeScreenState {
  const CustomersState()
      : super(const CustomerScreen()); // Replace with CustomersScreen
}

class ProfileState extends HomeScreenState {
  ProfileState() : super(ProfileScreen()); // Replace with ProfileScreen
}
