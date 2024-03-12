part of 'all_entries_bloc.dart';

sealed class AllEntriesEvent extends Equatable {
  const AllEntriesEvent();

  @override
  List<Object> get props => [];
}

final class AllEntriesFetchDataEvent extends AllEntriesEvent {}

final class AllEntriesFixDatesEvent extends AllEntriesEvent {}

final class AllEntriesDeleteEntryEvent extends AllEntriesEvent {
  final Entry entry;
  const AllEntriesDeleteEntryEvent({required this.entry});

  @override
  List<Object> get props => [entry];
}

final class AllEntriesIncreaseSpendEvent extends AllEntriesEvent {}

final class AllEntriesInsertListEvent extends AllEntriesEvent {}

final class AllEntriesInsertListForMonthEvent extends AllEntriesEvent {
  final DateTime date;
  const AllEntriesInsertListForMonthEvent({required this.date});

  @override
  List<Object> get props => [date];
}

final class AllEntriesDailySpendingEvent extends AllEntriesEvent {}

final class AllEntriesCompareFuncEvent extends AllEntriesEvent {}
