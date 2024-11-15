import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/flilter_dropdown/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/flilter_dropdown/bloc/bloc_state.dart';

class SalesFilterBloc extends Bloc<SalesFiltersEvent, SalesFilterState> {
  SalesFilterBloc() : super(SalesFilterInitial()) {
    on<ChangeDropdownSelectionEvent>(slecteFilter);
  }

  
  Future<void> slecteFilter(ChangeDropdownSelectionEvent event,
      Emitter<SalesFilterState> emit) async {
    emit(SalesReportDropdownSelected(event.selection));
    // You can also add logic here to load data for the selected option
  }
}
