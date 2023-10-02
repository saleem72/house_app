part of 'daily_summary_bloc.dart';

sealed class DailySummaryState extends Equatable {
  const DailySummaryState();

  @override
  List<Object> get props => [];
}

final class DailySummaryInitial extends DailySummaryState {}

final class DailySummaryLoading extends DailySummaryState {}

final class DailySummarySuccess implements DailySummaryState {
  final List<Entry> entries;

  const DailySummarySuccess({required this.entries});

  @override
  List<Object> get props => [entries];

  @override
  String toString() => '';

  @override
  bool? get stringify => true;
}
