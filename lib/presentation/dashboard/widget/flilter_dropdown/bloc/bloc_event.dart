import 'package:equatable/equatable.dart';

abstract class SalesFiltersEvent extends Equatable {
  const SalesFiltersEvent();
  @override
  List<Object> get props => [];
}

class ChangeDropdownSelectionEvent extends SalesFiltersEvent {
  final String selection;

  const ChangeDropdownSelectionEvent(this.selection);
  @override
  List<Object> get props => [selection];
}



