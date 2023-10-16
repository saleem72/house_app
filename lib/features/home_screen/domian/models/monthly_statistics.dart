//

import 'package:equatable/equatable.dart';
import 'package:house_app/core/extensions/date_time_extension.dart';
import 'package:house_app/core/extensions/int_extension.dart';
import 'package:house_app/features/home_screen/domian/models/button_category.dart';

class MonthlyStatistics extends Equatable {
  final int income;
  final int day;
  final int week;
  final int month;
  final int dayPercent;
  final int weekPercent;
  final int monthPercent;
  final int left;
  const MonthlyStatistics({
    required this.income,
    required this.day,
    required this.week,
    required this.month,
    required this.dayPercent,
    required this.weekPercent,
    required this.monthPercent,
    required this.left,
  });

  factory MonthlyStatistics.fromList(List<ExpenseCategory> event) {
    final date = DateTime.now();
    final days =
        DateSpecific.dayNumberForMonth(year: date.year, month: date.month);
    final income = event
        .firstWhere((element) => element.category == ButtonCategory.inCome)
        .amount;
    final day = event
        .firstWhere((element) => element.category == ButtonCategory.day)
        .amount;
    final week = event
        .firstWhere((element) => element.category == ButtonCategory.week)
        .amount;
    final month = event
        .firstWhere((element) => element.category == ButtonCategory.month)
        .amount;
    final int allowedPerDay = income.div(days);
    return MonthlyStatistics(
      income: income,
      day: day,
      week: week,
      month: month,
      dayPercent: (day * 100).div(allowedPerDay),
      weekPercent: (week * 100).div(allowedPerDay * 7),
      monthPercent: (month * 100).div(income),
      left: income - month,
    );
  }

  @override
  List<Object?> get props => [
        income,
        day,
        week,
        month,
        dayPercent,
        weekPercent,
        monthPercent,
        left,
      ];

  List<ExpenseCategoryWithPercent> list() => [
        ExpenseCategoryWithPercent(
          category: ButtonCategory.day,
          amount: day,
          percent: dayPercent,
        ),
        ExpenseCategoryWithPercent(
          category: ButtonCategory.week,
          amount: week,
          percent: weekPercent,
        ),
        ExpenseCategoryWithPercent(
          category: ButtonCategory.month,
          amount: month,
          percent: (month * 100).div(income),
        ),
        ExpenseCategoryWithPercent(
          category: ButtonCategory.inCome,
          amount: income,
          percent: income - month,
        ),
      ];
}
