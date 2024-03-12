// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'dart:math';

import 'package:equatable/equatable.dart';

import 'package:house_app/core/extensions/date_time_extension.dart';
import 'package:house_app/core/extensions/int_extension.dart';
import 'package:house_app/features/home_screen/domain/models/button_category.dart';

class MonthlyStatistics extends Equatable {
  final int income;
  final int day;
  final int week;
  final int month;
  final int dayPercent;
  final int weekPercent;
  final int monthPercent;
  final int leftForDay;
  final int leftForWeek;
  final int left;
  final int daysLeft;
  const MonthlyStatistics({
    required this.income,
    required this.day,
    required this.week,
    required this.month,
    required this.dayPercent,
    required this.weekPercent,
    required this.monthPercent,
    required this.left,
    required this.leftForDay,
    required this.leftForWeek,
    required this.daysLeft,
  });

  int get perDay => daysLeft == 0 ? left : left ~/ daysLeft;

  factory MonthlyStatistics.initial() => const MonthlyStatistics(
        income: 0,
        day: 0,
        week: 0,
        month: 0,
        dayPercent: 0,
        weekPercent: 0,
        monthPercent: 0,
        left: 0,
        leftForDay: 0,
        leftForWeek: 0,
        daysLeft: 0,
      );

  factory MonthlyStatistics.fromList(List<ExpenseCategory> event) {
    final date = DateTime.now();
    final dayLeft =
        DateSpecific.dayNumberForMonth(year: date.year, month: date.month) -
            date.day;
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
      dayPercent: income > 0 ? (day * 100).div(allowedPerDay) : 0,
      weekPercent: income > 0 ? (week * 100).div(allowedPerDay * 7) : 0,
      monthPercent: income > 0 ? (month * 100).div(income) : 0,
      left: income > 0 ? income - month : 0,
      leftForDay: income > 0 ? max(allowedPerDay - day, 0) : 0,
      leftForWeek: income > 0 ? max(allowedPerDay * 7 - week, 0) : 0,
      daysLeft: dayLeft,
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
        daysLeft
      ];

  List<ExpenseCategoryWithPercent> list() => [
        ExpenseCategoryWithPercent(
          category: ButtonCategory.day,
          amount: day,
          percent: dayPercent,
          left: leftForDay,
        ),
        ExpenseCategoryWithPercent(
            category: ButtonCategory.week,
            amount: week,
            percent: weekPercent,
            left: leftForWeek),
        ExpenseCategoryWithPercent(
          category: ButtonCategory.month,
          amount: month,
          percent: (month * 100).div(income),
          left: income > 0 ? income - month : 0,
        ),
        ExpenseCategoryWithPercent(
          category: ButtonCategory.inCome,
          amount: income,
          percent: (month * 100).div(income),
          left: left, // income - month,
        ),
      ];

  MonthlyStatistics copyWith({
    int? income,
    int? day,
    int? week,
    int? month,
    int? dayPercent,
    int? weekPercent,
    int? monthPercent,
    int? leftForDay,
    int? leftForWeek,
    int? left,
    int? daysLeft,
  }) {
    return MonthlyStatistics(
        income: income ?? this.income,
        day: day ?? this.day,
        week: week ?? this.week,
        month: month ?? this.month,
        dayPercent: dayPercent ?? this.dayPercent,
        weekPercent: weekPercent ?? this.weekPercent,
        monthPercent: monthPercent ?? this.monthPercent,
        leftForDay: leftForDay ?? this.leftForDay,
        leftForWeek: leftForWeek ?? this.leftForWeek,
        left: left ?? this.left,
        daysLeft: daysLeft ?? this.daysLeft);
  }
}
