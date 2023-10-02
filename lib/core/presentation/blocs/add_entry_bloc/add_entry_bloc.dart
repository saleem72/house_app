//

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/data/local_db/app_database.dart';
import 'package:house_app/core/data/local_db/daos/entry_dao/entry_dao.dart';
import 'package:house_app/core/domian/models/entry.dart';
import 'package:house_app/core/extensions/date_time_extension.dart';

part 'add_entry_event.dart';
part 'add_entry_state.dart';

class AddEntryBloc extends Bloc<AddEntryEvent, AddEntryState> {
  final EntryDAO _dao;
  final Entry? _entry;
  AddEntryBloc({
    required AppDatabase db,
    required DateTime date,
    Entry? entry,
  })  : _dao = db.entryDAO,
        _entry = entry,
        super(AddEntryState.initail().copyWith(
          date: date,
          amount: entry?.amount,
          description: entry?.description,
        )) {
    on<AddEntryDescriptionChangedEvent>(_onDescriptionHasChanged);
    on<AddEntryAmountChangedEvent>(_onAmountHasChanged);
    on<AddEntrySubmitEvent>(_onSubmit);
    on<AddEntryDateChangedEvent>(_onDateChanged);
  }

  _onDescriptionHasChanged(AddEntryDescriptionChangedEvent event,
      Emitter<AddEntryState> emit) async {
    emit(state.copyWith(
        description: event.description,
        isValid: isValid(state.amount, event.description)));
  }

  _onAmountHasChanged(
      AddEntryAmountChangedEvent event, Emitter<AddEntryState> emit) async {
    final anmount = int.parse(event.anmount.replaceAll(',', ''));
    emit(state.copyWith(
        amount: anmount, isValid: isValid(anmount, state.description)));
  }

  bool isValid(int amount, String description) {
    if (amount > 0 && description.trim().isNotEmpty) {
      return true;
    }
    return false;
  }

  _onSubmit(AddEntrySubmitEvent event, Emitter<AddEntryState> emit) async {
    Entry entry;
    if (_entry == null) {
      entry = Entry(
        id: 0,
        date: state.date.onlyDate(),
        amount: state.amount,
        description: state.description,
        isIncome: false,
      );
      await _dao.addEntry(entry);
    } else {
      entry = Entry(
        id: _entry!.id,
        date: state.date.onlyDate(),
        amount: state.amount,
        description: state.description,
        isIncome: false,
      );
      await _dao.updateEntry(entry);
    }

    emit(AddEntryState.initail());
  }

  _onDateChanged(AddEntryDateChangedEvent event, Emitter<AddEntryState> emit) {
    emit(state.copyWith(date: event.date));
  }
}
