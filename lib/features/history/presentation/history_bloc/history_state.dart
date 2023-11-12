// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'history_bloc.dart';

class HistoryState extends Equatable {
  final DateTime date;
  final List<WeekExpnces> expenses;
  final MonthTotal statistics;
  final List<DailySpending> dailySpendings;
  const HistoryState({
    required this.date,
    required this.expenses,
    required this.statistics,
    required this.dailySpendings,
  });

  @override
  List<Object> get props => [date, expenses, dailySpendings];

  factory HistoryState.initial() => HistoryState(
        date: DateTime.now(),
        expenses: const [],
        statistics: MonthTotal(date: DateTime.now(), income: 0, spendings: 0),
        dailySpendings: const [],
      );

  HistoryState copyWith({
    DateTime? date,
    List<WeekExpnces>? expenses,
    MonthTotal? statistics,
    List<DailySpending>? dailySpendings,
  }) {
    return HistoryState(
      date: date ?? this.date,
      expenses: expenses ?? this.expenses,
      statistics: statistics ?? this.statistics,
      dailySpendings: dailySpendings ?? this.dailySpendings,
    );
  }
}
