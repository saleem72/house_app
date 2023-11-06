part of 'income_bloc.dart';

sealed class IncomeEvent extends Equatable {
  const IncomeEvent();

  @override
  List<Object> get props => [];
}

final class IncomeSubscribeEvent extends IncomeEvent {}

final class _IncomeNewEntriesEvent extends IncomeEvent {
  final List<Entry> data;

  const _IncomeNewEntriesEvent({required this.data});

  @override
  List<Object> get props => [data];
}

final class IncomeDeleteEntryEvent extends IncomeEvent {
  final Entry entry;

  const IncomeDeleteEntryEvent({required this.entry});

  @override
  List<Object> get props => [entry];
}
