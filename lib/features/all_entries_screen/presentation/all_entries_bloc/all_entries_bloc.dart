//

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/domian/models/entry.dart';
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
  }

  FutureOr<void> _onFetchData(
      AllEntriesFetchDataEvent event, Emitter<AllEntriesState> emit) async {
    final data = await repository.fetchData();
    emit(AllEntriesSuccess(entries: data));
  }
}
