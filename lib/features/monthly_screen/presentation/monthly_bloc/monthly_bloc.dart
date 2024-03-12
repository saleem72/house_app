//

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/domain/models/week_expenses.dart';
import 'package:house_app/features/monthly_screen/domain/repository/i_monthly_repository.dart';

part 'monthly_event.dart';
part 'monthly_state.dart';

class MonthlyBloc extends Bloc<MonthlyEvent, MonthlyState> {
  final IMonthlyRepository _repository;
  MonthlyBloc({
    required IMonthlyRepository repository,
  })  : _repository = repository,
        super(MonthlyInitial()) {
    on<MonthlyFetchDataEvent>(_onFetchData);
  }

  _onFetchData(MonthlyFetchDataEvent event, Emitter<MonthlyState> emit) async {
    emit(MonthlyLoading());

    final data = await _repository.fetchData();

    emit(MonthlySuccess(weeks: data));
  }
}
