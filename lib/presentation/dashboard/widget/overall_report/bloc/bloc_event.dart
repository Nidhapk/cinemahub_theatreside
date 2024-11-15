import 'package:equatable/equatable.dart';

abstract class OverallReportEvent extends Equatable {
  const OverallReportEvent();
  @override
  List<Object> get props => [];
}

class FetchOverallReportEvent extends OverallReportEvent {
  final String movieName;
  const FetchOverallReportEvent(this.movieName);
  @override
  List<Object> get props => [movieName];
}
