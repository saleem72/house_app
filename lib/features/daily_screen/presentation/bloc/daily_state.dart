part of 'daily_bloc.dart';

sealed class DailyState extends Equatable {
  const DailyState();

  @override
  List<Object?> get props => [];
}

final class DailyInitial extends DailyState {}

final class DailyLoading extends DailyState {}

final class DailySuccess implements DailyState {
  final List<Entry> entries;

  const DailySuccess({required this.entries});

  @override
  List<Object?> get props => [entries];

  @override
  String toString() => '';

  @override
  bool? get stringify => true;
}
