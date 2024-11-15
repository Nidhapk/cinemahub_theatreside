import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/repository/sales_report_repository.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/sales_report/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/sales_report/bloc/bloc_states.dart';

class SalesReportBloc extends Bloc<SalesReportEvent, SalesReportStates> {
  SalesReportBloc() : super(const SalesReportInitialState()) {
    on<FetchsalesReportEvent>(fatchSalesReport);
  }

  Future<void> fatchSalesReport(
      FetchsalesReportEvent event, Emitter<SalesReportStates> emit) async {
    try {
      final salesReport = await SalesReportRepository().getSalesSpots(event.movieName);
      emit(
        SalesReportLoaded(salesReport),
      );
    } catch (e) {
      emit(
        SalesReportLoadedError('Error: $e'),
      );
    }
  }
}
