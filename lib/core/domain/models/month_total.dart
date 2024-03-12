//

import 'package:equatable/equatable.dart';

class MonthSummaryEntry {
  final bool isIncome;
  final int spending;
  const MonthSummaryEntry({
    required this.isIncome,
    required this.spending,
  });
}

class MonthTotal extends Equatable {
  final DateTime date;
  final int income;
  final int spending;
  const MonthTotal({
    required this.date,
    required this.income,
    required this.spending,
  });

  int get left => income - spending;

  @override
  List<Object?> get props => [date, income, spending];
}
