part of 'weekly_bloc.dart';

sealed class WeeklyEvent extends Equatable {
  const WeeklyEvent();

  @override
  List<Object> get props => [];
}

final class WeekFetchDataEvent extends WeeklyEvent {}

final class WeekFetchDataForDateEvent extends WeeklyEvent {
  final DateTime date;

  const WeekFetchDataForDateEvent({
    required this.date,
  });
}
