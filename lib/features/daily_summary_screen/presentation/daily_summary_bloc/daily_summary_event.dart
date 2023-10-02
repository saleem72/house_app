part of 'daily_summary_bloc.dart';

sealed class DailySummaryEvent extends Equatable {
  const DailySummaryEvent();

  @override
  List<Object?> get props => [];
}

final class DailySummaryFetchDateEvent implements DailySummaryEvent {
  final DateTime date;

  const DailySummaryFetchDateEvent({
    required this.date,
  });

  @override
  List<Object?> get props => [date];

  @override
  bool? get stringify => true;
}
