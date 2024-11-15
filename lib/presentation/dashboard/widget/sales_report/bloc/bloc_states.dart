import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';

class SalesReportStates extends Equatable {
  const SalesReportStates();
  @override
  List<Object> get props => [];
}

class SalesReportInitialState extends SalesReportStates {
  const SalesReportInitialState();
  @override
  List<Object> get props => [];
}

class SalesReportLoaded extends SalesReportStates {
  final List<FlSpot> salesMap;
  const SalesReportLoaded(this.salesMap);
  @override
  List<Object> get props => [salesMap];
}
class SalesReportLoadedError extends SalesReportStates {
  final String error;
  const SalesReportLoadedError(this.error);
  @override
  List<Object> get props => [error];
}