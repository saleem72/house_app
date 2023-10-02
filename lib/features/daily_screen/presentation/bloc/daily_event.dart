part of 'daily_bloc.dart';

sealed class DailyEvent extends Equatable {
  const DailyEvent();

  @override
  List<Object?> get props => [];
}

final class DailyFetchDataEvent extends DailyEvent {}

final class DailyFetchDataForDateEvent extends DailyEvent {
  final DateTime date;

  const DailyFetchDataForDateEvent({required this.date});

  @override
  List<Object?> get props => [date];
}

final class DailySubscribeDataEvent extends DailyEvent {}

final class _DailyNewEntriesEvent extends DailyEvent {
  final List<Entry> data;

  const _DailyNewEntriesEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

final class DailyDeleteEntryEvent extends DailyEvent {
  final Entry entry;

  const DailyDeleteEntryEvent({required this.entry});

  @override
  List<Object?> get props => [entry];
}
