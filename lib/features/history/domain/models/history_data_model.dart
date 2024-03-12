// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:house_app/core/domain/models/daily_spending.dart';
import 'package:house_app/core/domain/models/month_total.dart';
import 'package:house_app/core/domain/models/week_expenses.dart';

class HistoryDataModel {
  final List<WeekExpenses> expenses;
  final MonthTotal statistics;
  final List<DailySpending> dailySpendings;

  const HistoryDataModel({
    required this.expenses,
    required this.statistics,
    required this.dailySpendings,
  });
}
