part of 'history_bloc.dart';

sealed class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

final class HistoryFetchDataEvent extends HistoryEvent {}

final class HistoryDateChangedEvent extends HistoryEvent {
  final DateTime date;
  const HistoryDateChangedEvent({required this.date});

  @override
  List<Object> get props => [date];
}
