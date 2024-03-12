// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'statistic_bloc.dart';

class StatisticState extends Equatable {
  final MonthlyStatistics expenses;
  final List<DailySpending> dailySpending;

  const StatisticState({
    required this.expenses,
    required this.dailySpending,
  });

  @override
  List<Object> get props => [expenses, dailySpending];

  factory StatisticState.initial() => StatisticState(
        expenses: MonthlyStatistics.initial(),
        dailySpending: const [],
      );

  StatisticState copyWith({
    MonthlyStatistics? expenses,
    List<DailySpending>? dailySpending,
  }) {
    return StatisticState(
      expenses: expenses ?? this.expenses,
      dailySpending: dailySpending ?? this.dailySpending,
    );
  }
}
