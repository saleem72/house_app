part of 'weekly_bloc.dart';

sealed class WeeklyState extends Equatable {
  const WeeklyState();

  @override
  List<Object?> get props => [];
}

final class WeeklyInitial extends WeeklyState {}

final class WeeklyLoading extends WeeklyState {}

final class WeeklySuccess implements WeeklyState {
  final List<DateSummary> entries;

  const WeeklySuccess({required this.entries});

  @override
  List<Object?> get props => [entries];

  @override
  String toString() => '';

  @override
  bool? get stringify => true;
}
