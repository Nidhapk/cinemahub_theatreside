import 'package:equatable/equatable.dart';

abstract class SalesReportEvent extends Equatable {
  const SalesReportEvent();
  @override
  List<Object> get props => [];
}

class FetchsalesReportEvent extends SalesReportEvent {
  final String movieName;
  const FetchsalesReportEvent(this.movieName);
  @override
  List<Object> get props => [movieName];
}
