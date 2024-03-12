part of 'all_entries_bloc.dart';

sealed class AllEntriesState extends Equatable {
  const AllEntriesState();

  @override
  List<Object> get props => [];
}

final class AllEntriesInitial extends AllEntriesState {}

final class AllEntriesLoading extends AllEntriesState {}

final class AllEntriesSuccess extends AllEntriesState {
  final List<Entry> entries;

  const AllEntriesSuccess({required this.entries});

  @override
  List<Object> get props => [entries];
}

final class AllEntriesSpending extends AllEntriesState {
  final double spends;

  const AllEntriesSpending({required this.spends});

  @override
  List<Object> get props => [spends];
}

final class AllEntriesDailySpending extends AllEntriesState {
  final List<DailySpending> spending;

  const AllEntriesDailySpending({required this.spending});

  @override
  List<Object> get props => [spending];
}

final class AllEntriesMonthExpenses extends AllEntriesState {
  final List<WeekExpenses> expenses;

  const AllEntriesMonthExpenses({required this.expenses});

  @override
  List<Object> get props => [expenses];
}
