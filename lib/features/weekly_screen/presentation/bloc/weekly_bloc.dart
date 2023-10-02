//

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/domian/models/date_summary.dart';
import 'package:house_app/core/domian/models/week_expnces.dart';
import 'package:house_app/features/weekly_screen/domain/repository/i_weekly_repository.dart';

part 'weekly_event.dart';
part 'weekly_state.dart';

class WeeklyBloc extends Bloc<WeeklyEvent, WeeklyState> {
  final WeekExpnces? week;
  final IWeeklyRepository _repository;
  WeeklyBloc({required IWeeklyRepository repository, this.week})
      : _repository = repository,
        super(WeeklyInitial()) {
    on<WeekFetchDataEvent>(_onFetchData);
    on<WeekFetchDataForDateEvent>(_onFetchDataForDate);
  }

  FutureOr<void> _onFetchData(
      WeekFetchDataEvent event, Emitter<WeeklyState> emit) async {
    emit(WeeklyLoading());
    final date = week?.days.first ?? DateTime.now();
    final data = await _repository.fetchData(date);
    data.sort((a, b) {
      return a.date.compareTo(b.date);
    });
    emit(WeeklySuccess(entries: data));
  }

  FutureOr<void> _onFetchDataForDate(
      WeekFetchDataForDateEvent event, Emitter<WeeklyState> emit) async {
    emit(WeeklyLoading());
    final data = await _repository.fetchData(event.date);
    data.sort((a, b) {
      return a.date.compareTo(b.date);
    });
    emit(WeeklySuccess(entries: data));
  }
}
