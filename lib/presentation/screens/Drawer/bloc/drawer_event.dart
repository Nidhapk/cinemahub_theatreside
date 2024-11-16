import 'package:equatable/equatable.dart';

abstract class HomeScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NavigateToDashboardEvent extends HomeScreenEvent {
  NavigateToDashboardEvent();
  @override
  List<Object> get props => [];
}

class NavigateToRoomsEvent extends HomeScreenEvent {}

class NavigateToBookingsEvent extends HomeScreenEvent {}

class NavigateToCustomersEvent extends HomeScreenEvent {}

class NavigateToProfileEvent extends HomeScreenEvent {}

class LogoutEvent extends HomeScreenEvent {}
