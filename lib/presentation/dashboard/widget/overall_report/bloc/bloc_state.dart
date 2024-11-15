import 'package:equatable/equatable.dart';

abstract class OverAllReportStates extends Equatable {
  const OverAllReportStates();
  @override
  List<Object> get props => [];
}

class OverAllReportinitial extends OverAllReportStates {
  const OverAllReportinitial();
  @override
  List<Object> get props => [];
}

class OverAllReportLoadedState extends OverAllReportinitial {
  final Map<String, dynamic> details;
  const OverAllReportLoadedState(this.details);
  @override
  List<Object> get props => [details];
}

class OverAllReportLoadedErrorState extends OverAllReportinitial {
  final String error;
  const OverAllReportLoadedErrorState(this.error);
  @override
  List<Object> get props => [error];
}
