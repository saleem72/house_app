//

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:house_app/core/domain/models/entry.dart';
import 'package:house_app/core/extensions/date_time_extension.dart';
import 'package:house_app/features/daily_screen/domain/repository/i_daily_repository.dart';

part 'daily_event.dart';
part 'daily_state.dart';

class DailyBloc extends Bloc<DailyEvent, DailyState> {
  final IDailyRepository _repository;
  DateTime date = DateTime.now();
  StreamSubscription<List<Entry>>? _subscription;
  DailyBloc({required IDailyRepository repository})
      : _repository = repository,
        super(DailyInitial()) {
    on<DailyFetchDataEvent>(_onFetchData);
    on<DailyFetchDataForDateEvent>(_onFetchDataForDate);

    on<DailySubscribeDataEvent>(_onSubscribe);
    on<_DailyNewEntriesEvent>(_onNewEntries);
    on<DailyDeleteEntryEvent>(_onDeleteEntry);
  }

  _onSubscribe(DailySubscribeDataEvent event, Emitter<DailyState> emit) {
    final date = DateTime.now().onlyDate();
    _subscription = _repository.subscribe(date).listen((event) {
      add(_DailyNewEntriesEvent(data: event));
    });
  }

  _onNewEntries(_DailyNewEntriesEvent event, Emitter<DailyState> emit) {
    emit(DailySuccess(entries: event.data));
  }

  FutureOr<void> _onFetchData(
      DailyFetchDataEvent event, Emitter<DailyState> emit) async {
    emit(DailyLoading());

    final data = await _repository.fetchData(DateTime.now());
    emit(DailySuccess(entries: data));
  }

  FutureOr<void> _onFetchDataForDate(
      DailyFetchDataForDateEvent event, Emitter<DailyState> emit) async {
    // emit(DailyLoading());

    // final data = await _repository.fetchData(event.date);
    // emit(DailySuccess(entries: data));
    date = event.date;
    _subscription?.cancel();
    _subscription = _repository.subscribe(event.date).listen((event) {
      add(_DailyNewEntriesEvent(data: event));
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _repository.dispose();
    return super.close();
  }

  _onDeleteEntry(DailyDeleteEntryEvent event, Emitter<DailyState> emit) async {
    _repository.deleteEntry(entry: event.entry);
  }
}
