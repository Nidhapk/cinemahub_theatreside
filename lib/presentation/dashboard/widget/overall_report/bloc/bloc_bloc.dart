import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/repository/sales_report_repository.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/overall_report/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/overall_report/bloc/bloc_state.dart';

class OverallReportBloc extends Bloc<OverallReportEvent, OverAllReportStates> {
  OverallReportBloc() : super(const OverAllReportinitial()) {
    on<FetchOverallReportEvent>(overallBookings);
  }

  Future<void> overallBookings(
      FetchOverallReportEvent event, Emitter<OverAllReportStates> emit) async {
    try {
      final report =
          await SalesReportRepository().calculatebookings(event.movieName);
      emit(OverAllReportLoadedState(report));
      log('Report data loaded.');
    } catch (e) {
      emit(OverAllReportLoadedErrorState('error: $e'));
    }
  }
}
