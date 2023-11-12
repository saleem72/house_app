// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:house_app/core/domian/models/daily_spending.dart';
import 'package:house_app/core/domian/models/month_total.dart';
import 'package:house_app/core/domian/models/week_expnces.dart';

class HistoryDataModel {
  final List<WeekExpnces> expenses;
  final MonthTotal statistics;
  final List<DailySpending> dailySpendings;

  const HistoryDataModel({
    required this.expenses,
    required this.statistics,
    required this.dailySpendings,
  });
}
