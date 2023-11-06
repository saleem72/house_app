//

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/domian/models/daily_spending.dart';
import 'package:house_app/features/home_screen/domian/models/monthly_statistics.dart';

import '../../domian/repository/i_home_repository.dart';

part 'statistic_event.dart';
part 'statistic_state.dart';

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  final IHomeRepository _repository;
  StreamSubscription<MonthlyStatistics>? _subscription;
  StatisticBloc({
    required IHomeRepository repository,
  })  : _repository = repository,
        super(StatisticState.initial()) {
    on<HomeSubscribeEvent>(_onSubscribe);
    on<_HomeNewListEvent>(_onNewList);
    on<_HomeFetchDailySpendingsEvent>(_onFetchDailySpendings);
  }

  FutureOr<void> _onSubscribe(
      HomeSubscribeEvent event, Emitter<StatisticState> emit) {
    _subscription = _repository.subcribe().listen((event) {
      add(_HomeNewListEvent(expenses: event));
      add(_HomeFetchDailySpendingsEvent());
    });
  }

  FutureOr<void> _onNewList(
      _HomeNewListEvent event, Emitter<StatisticState> emit) {
    emit(state.copyWith(expenses: event.expenses));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _repository.dispose();
    return super.close();
  }

  FutureOr<void> _onFetchDailySpendings(
      _HomeFetchDailySpendingsEvent event, Emitter<StatisticState> emit) async {
    final data = await _repository.sumDayInEntries();
    emit(state.copyWith(dailySpendings: data));
  }
}
