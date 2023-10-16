part of 'add_entry_bloc.dart';

sealed class AddEntryEvent extends Equatable {
  const AddEntryEvent();

  @override
  List<Object> get props => [];
}

final class AddEntryDateChangedEvent extends AddEntryEvent {
  final DateTime date;

  const AddEntryDateChangedEvent({
    required this.date,
  });

  @override
  List<Object> get props => [date];
}

final class AddEntryAmountChangedEvent extends AddEntryEvent {
  final String anmount;

  const AddEntryAmountChangedEvent({
    required this.anmount,
  });

  @override
  List<Object> get props => [anmount];
}

final class AddEntryDescriptionChangedEvent extends AddEntryEvent {
  final String description;

  const AddEntryDescriptionChangedEvent({
    required this.description,
  });

  @override
  List<Object> get props => [description];
}

final class AddEntrySubmitEvent extends AddEntryEvent {}

final class AddIncomeSubmitEvent extends AddEntryEvent {}
