//

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/domain/models/entry.dart';
import 'package:house_app/features/daily_summary_screen/domain/repository/i_daily_summary_repository.dart';

part 'daily_summary_event.dart';
part 'daily_summary_state.dart';

class DailySummaryBloc extends Bloc<DailySummaryEvent, DailySummaryState> {
  final IDailySummaryRepository _repository;
  DailySummaryBloc({
    required IDailySummaryRepository repository,
  })  : _repository = repository,
        super(DailySummaryInitial()) {
    on<DailySummaryFetchDateEvent>(_onFetchDateEvent);
  }

  FutureOr<void> _onFetchDateEvent(
      DailySummaryFetchDateEvent event, Emitter<DailySummaryState> emit) async {
    emit(DailySummaryLoading());

    final data = await _repository.fetchData(event.date);
    emit(DailySummarySuccess(entries: data));
  }
}
