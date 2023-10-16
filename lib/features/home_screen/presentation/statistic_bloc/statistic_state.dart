part of 'statistic_bloc.dart';

sealed class StatisticState extends Equatable {
  const StatisticState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends StatisticState {}

final class HomeLoading extends StatisticState {}

final class HomeSuccess extends StatisticState {
  final MonthlyStatistics expenses;

  const HomeSuccess({required this.expenses});

  @override
  List<Object> get props => [expenses];
}
