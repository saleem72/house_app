//

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/domian/models/entry.dart';
import 'package:house_app/features/income/domain/repository/i_income_repository.dart';

part 'income_event.dart';
part 'income_state.dart';

class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
  final IIncomeRepository _repository;
  StreamSubscription<List<Entry>>? _subscription;

  IncomeBloc({required IIncomeRepository repository})
      : _repository = repository,
        super(IncomeState.initial()) {
    on<IncomeSubscribeEvent>(_onSubscribe);
    on<_IncomeNewEntriesEvent>(_onNewEntries);
    on<IncomeDeleteEntryEvent>(_onDeleteEntry);
  }

  @override
  Future<void> close() {
    _repository.dispose();
    _subscription?.cancel();
    return super.close();
  }

  FutureOr<void> _onSubscribe(
      IncomeSubscribeEvent event, Emitter<IncomeState> emit) {
    _subscription = _repository.subscribe().listen((event) {
      add(_IncomeNewEntriesEvent(data: event));
    });
  }

  _onNewEntries(_IncomeNewEntriesEvent event, Emitter<IncomeState> emit) {
    emit(state.copyWith(entries: event.data));
  }

  FutureOr<void> _onDeleteEntry(
      IncomeDeleteEntryEvent event, Emitter<IncomeState> emit) {
    _repository.deleteEntry(entry: event.entry);
  }
}
