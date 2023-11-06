part of 'statistic_bloc.dart';

sealed class StatisticEvent extends Equatable {
  const StatisticEvent();

  @override
  List<Object> get props => [];
}

final class HomeSubscribeEvent extends StatisticEvent {}

final class _HomeNewListEvent extends StatisticEvent {
  final MonthlyStatistics expenses;

  const _HomeNewListEvent({required this.expenses});

  @override
  List<Object> get props => [expenses];
}

final class _HomeFetchDailySpendingsEvent extends StatisticEvent {}
