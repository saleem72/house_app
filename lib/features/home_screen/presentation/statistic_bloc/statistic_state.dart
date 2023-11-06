// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'statistic_bloc.dart';

class StatisticState extends Equatable {
  final MonthlyStatistics expenses;
  final List<DailySpending> dailySpendings;

  const StatisticState({
    required this.expenses,
    required this.dailySpendings,
  });

  @override
  List<Object> get props => [expenses, dailySpendings];

  factory StatisticState.initial() => StatisticState(
        expenses: MonthlyStatistics.initial(),
        dailySpendings: const [],
      );

  StatisticState copyWith({
    MonthlyStatistics? expenses,
    List<DailySpending>? dailySpendings,
  }) {
    return StatisticState(
      expenses: expenses ?? this.expenses,
      dailySpendings: dailySpendings ?? this.dailySpendings,
    );
  }
}
