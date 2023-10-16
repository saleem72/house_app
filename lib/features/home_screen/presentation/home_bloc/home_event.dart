part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class HomeFetchDataEvent extends HomeEvent {}

final class HomeSubscribeEvent extends HomeEvent {}

final class _HomeNewListEvent extends HomeEvent {
  final List<ExpenseCategoryWithPercent> expenses;

  const _HomeNewListEvent({required this.expenses});

  @override
  List<Object> get props => [expenses];
}
