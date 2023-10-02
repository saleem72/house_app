//

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domian/models/button_category.dart';
import '../../domian/repository/i_home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IHomeRepository _repository;
  StreamSubscription<List<ExpenseCategory>>? _subscription;
  HomeBloc({
    required IHomeRepository repository,
  })  : _repository = repository,
        super(HomeInitial()) {
    on<HomeFetchDataEvent>(_onFetchData);
    on<HomeSubscribeEvent>(_onSubscribe);
    on<_HomeNewListEvent>(_onNewList);
  }

  _onFetchData(HomeFetchDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final data = await _repository.fetchData();
    emit(HomeSuccess(expenses: data));
  }

  FutureOr<void> _onSubscribe(
      HomeSubscribeEvent event, Emitter<HomeState> emit) {
    _subscription = _repository.subcribe().listen((event) {
      add(_HomeNewListEvent(expenses: event));
    });
  }

  FutureOr<void> _onNewList(_HomeNewListEvent event, Emitter<HomeState> emit) {
    emit(HomeSuccess(expenses: event.expenses));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _repository.dispose();
    return super.close();
  }
}
