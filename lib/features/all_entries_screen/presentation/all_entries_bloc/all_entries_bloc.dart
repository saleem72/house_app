//

import 'dart:async';
import 'dart:math' as math;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/data/local_db/database_utils.dart';
import 'package:house_app/core/domian/models/daily_spending.dart';
import 'package:house_app/core/domian/models/entry.dart';
import 'package:house_app/core/extensions/date_time_extension.dart';
import 'package:house_app/dependancy_injection.dart' as di;

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
    on<AllEntriesDailySpendingsEvent>(_onDailySpendings);
  }

  FutureOr<void> _onFetchData(
      AllEntriesFetchDataEvent event, Emitter<AllEntriesState> emit) async {
    final data = await repository.fetchData();
    emit(AllEntriesSuccess(entries: data));
  }

  FutureOr<void> _onIncreaseSpends(
      AllEntriesIncreaseSpendEvent event, Emitter<AllEntriesState> emit) {
    double spends =
        state is AllEntriesSpending ? (state as AllEntriesSpending).spends : 0;
    spends += 25;
    final tagget = math.min(spends, 100.0);
    emit(AllEntriesSpending(spends: tagget));
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

  FutureOr<void> _onDailySpendings(AllEntriesDailySpendingsEvent event,
      Emitter<AllEntriesState> emit) async {
    final data = await repository.sumDayInEntries();
    emit(AllEntriesDailySpending(spendings: data));
  }
}
