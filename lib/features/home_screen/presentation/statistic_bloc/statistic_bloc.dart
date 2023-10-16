//

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        super(HomeInitial()) {
    on<HomeFetchDataEvent>(_onFetchData);
    on<HomeSubscribeEvent>(_onSubscribe);
    on<_HomeNewListEvent>(_onNewList);
  }

  _onFetchData(HomeFetchDataEvent event, Emitter<StatisticState> emit) async {
    emit(HomeLoading());
    // final data = await _repository.fetchData();
    // emit(HomeSuccess(expenses: data));
  }

  FutureOr<void> _onSubscribe(
      HomeSubscribeEvent event, Emitter<StatisticState> emit) {
    _subscription = _repository.subcribe().listen((event) {
      add(_HomeNewListEvent(expenses: event));
    });
  }

  FutureOr<void> _onNewList(
      _HomeNewListEvent event, Emitter<StatisticState> emit) {
    emit(HomeSuccess(expenses: event.expenses));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _repository.dispose();
    return super.close();
  }
}
