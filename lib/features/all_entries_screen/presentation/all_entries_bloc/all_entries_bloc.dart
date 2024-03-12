//

import 'dart:async';
import 'dart:math' as math;
import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/data/local_db/database_utils.dart';
import 'package:house_app/core/domain/models/daily_spending.dart';
import 'package:house_app/core/domain/models/entry.dart';
import 'package:house_app/core/domain/models/week_expenses.dart';
import 'package:house_app/core/extensions/date_time_extension.dart';
import 'package:house_app/dependency_injection.dart' as di;

import '../../data/repository/all_entries_repository.dart';

part 'all_entries_event.dart';
part 'all_entries_state.dart';

class AllEntriesBloc extends Bloc<AllEntriesEvent, AllEntriesState> {
  final AllEntriesRepository repository = AllEntriesRepository(
    db: di.locator(),
    mapper: di.locator(),
  );
  AllEntriesBloc() : super(AllEntriesInitial()) {
    on<AllEntriesFetchDataEvent>(_onFetchData);
    on<AllEntriesIncreaseSpendEvent>(_onIncreaseSpends);
    on<AllEntriesInsertListEvent>(_onInsertList);
    on<AllEntriesDailySpendingEvent>(_onDailySpending);
    on<AllEntriesCompareFuncEvent>(_onCompareFunc);
    on<AllEntriesInsertListForMonthEvent>(_onInsertListForMonth);
    on<AllEntriesDeleteEntryEvent>(_onDeleteEntry);
    on<AllEntriesFixDatesEvent>(_onFixDates);
  }

  FutureOr<void> _onFetchData(
      AllEntriesFetchDataEvent event, Emitter<AllEntriesState> emit) async {
    // final data = await repository.fetchData();
    // emit(AllEntriesSuccess(entries: data));

    emit(AllEntriesInitial());
  }

  FutureOr<void> _onIncreaseSpends(
      AllEntriesIncreaseSpendEvent event, Emitter<AllEntriesState> emit) {
    double spends =
        state is AllEntriesSpending ? (state as AllEntriesSpending).spends : 0;
    spends += 25;
    final target = math.min(spends, 100.0);
    emit(AllEntriesSpending(spends: target));
  }

  FutureOr<void> _onInsertList(
      AllEntriesInsertListEvent event, Emitter<AllEntriesState> emit) async {
    final List<Entry> data = [];
    for (var i = 1; i < 100; i++) {
      final date = AppRandoms.randomDate(back: 20);
      final amount = AppRandoms.randomInt();
      data.add(
        Entry(
          id: 0,
          date: date.onlyDate(),
          amount: amount,
          description: '',
          isIncome: false,
        ),
      );
    }
    await repository.insertListOfEntries(data);
  }

  FutureOr<void> _onDailySpending(
      AllEntriesDailySpendingEvent event, Emitter<AllEntriesState> emit) async {
    final data = await repository.sumDayInEntries();
    emit(AllEntriesDailySpending(spending: data));
  }

  FutureOr<void> _onCompareFunc(
      AllEntriesCompareFuncEvent event, Emitter<AllEntriesState> emit) async {
    final data = await repository.getMonth(2023, 11);
    emit(AllEntriesMonthExpenses(expenses: data));
  }

  FutureOr<void> _onInsertListForMonth(AllEntriesInsertListForMonthEvent event,
      Emitter<AllEntriesState> emit) async {
    developer.log(event.date.toIso8601String(), name: 'all.entries');
    final month = event.date.month;
    final List<Entry> data = [];
    for (var i = 1; i < 100; i++) {
      final date = AppRandoms.randomDate(end: event.date, back: 30);
      final amount = AppRandoms.randomInt(
        from: month == 10 ? 7000 : 2000,
        to: month == 10 ? 25000 : 15000,
      );
      data.add(
        Entry(
          id: 0,
          date: date.onlyDate(),
          amount: amount,
          description: '',
          isIncome: false,
        ),
      );
    }
    if (month == 10) {
      data.add(
        Entry(
          id: 0,
          date: DateTime(2023, 10, 1),
          amount: 2500000,
          description: 'Salary 10',
          isIncome: true,
        ),
      );
    } else {
      data.add(
        Entry(
          id: 0,
          date: DateTime(2023, month, 1),
          amount: 1500000,
          description: 'Salary $month',
          isIncome: true,
        ),
      );
    }
    await repository.insertListOfEntries(data);
  }

  FutureOr<void> _onDeleteEntry(
      AllEntriesDeleteEntryEvent event, Emitter<AllEntriesState> emit) async {
    await repository.deleteEntry(event.entry);
    add(AllEntriesFetchDataEvent());
  }

  FutureOr<void> _onFixDates(
      AllEntriesFixDatesEvent event, Emitter<AllEntriesState> emit) async {
    await repository.fixDates();
    // print('I fixed it');
  }
}
