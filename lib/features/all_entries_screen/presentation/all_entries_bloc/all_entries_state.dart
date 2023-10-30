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
  final List<DailySpending> spendings;

  const AllEntriesDailySpending({required this.spendings});

  @override
  List<Object> get props => [spendings];
}
