//

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/domain/models/daily_spending.dart';
import 'package:house_app/core/domain/models/month_total.dart';
import 'package:house_app/core/domain/models/week_expenses.dart';
import 'package:house_app/features/history/domain/repository/i_history_repository.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final IHistoryRepository _repository;
  HistoryBloc({required IHistoryRepository repository})
      : _repository = repository,
        super(HistoryState.initial()) {
    on<HistoryFetchDataEvent>(_onFetchData);
    on<HistoryDateChangedEvent>(_onDateChanged);
  }

  FutureOr<void> _onFetchData(
      HistoryFetchDataEvent event, Emitter<HistoryState> emit) async {
    final data = await _repository.fetchData(state.date);
    emit(state.copyWith(
      expenses: data.expenses,
      statistics: data.statistics,
      dailySpendings: data.dailySpendings,
    ));
  }

  FutureOr<void> _onDateChanged(
      HistoryDateChangedEvent event, Emitter<HistoryState> emit) async {
    final data = await _repository.fetchData(event.date);

    emit(state.copyWith(
      date: event.date,
      expenses: data.expenses,
      statistics: data.statistics,
      dailySpendings: data.dailySpendings,
    ));
  }
}
