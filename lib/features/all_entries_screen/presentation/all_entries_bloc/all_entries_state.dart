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
