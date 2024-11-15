import 'package:equatable/equatable.dart';

abstract class SalesFilterState extends Equatable {
  const SalesFilterState();
  @override
  List<Object> get props => [];
}

class SalesFilterInitial extends SalesFilterState {}

class SalesReportDropdownSelected extends SalesFilterState {
  final String selectedOption;

 const SalesReportDropdownSelected(this.selectedOption);
 @override
  List<Object> get props => [selectedOption];
}
