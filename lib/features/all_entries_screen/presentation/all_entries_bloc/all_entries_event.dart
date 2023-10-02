part of 'all_entries_bloc.dart';

sealed class AllEntriesEvent extends Equatable {
  const AllEntriesEvent();

  @override
  List<Object> get props => [];
}

final class AllEntriesFetchDataEvent extends AllEntriesEvent {}
