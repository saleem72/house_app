// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:flutter/material.dart';

import 'package:house_app/configuration/routing/app_screens.dart';
import 'package:house_app/core/extensions/date_time_extension.dart';
import 'package:house_app/core/extensions/int_extension.dart';

enum ButtonCategory {
  month,
  week,
  day,
  inCome;

  String get label {
    return toString().split('.').last;
  }

  static ButtonCategory fromInt(int value) {
    switch (value) {
      case 0:
        return ButtonCategory.month;
      case 1:
        return ButtonCategory.week;
      case 2:
        return ButtonCategory.day;
      case 3:
        return ButtonCategory.inCome;
      default:
        return ButtonCategory.day;
    }
  }

  Color get color {
    switch (this) {
      case ButtonCategory.month:
        return const Color(0xFFFFEFE7);
      case ButtonCategory.week:
        return const Color(0xFFE8F0FB);
      case ButtonCategory.day:
        return const Color(0xFFFDEBF9);
      case ButtonCategory.inCome:
        return const Color(0xFFFFFFFF);
    }
  }

  Color get accentColor {
    switch (this) {
      case ButtonCategory.month:
        return const Color(0xFFFF5151);
      case ButtonCategory.week:
        return const Color(0xFF3786F1);
      case ButtonCategory.day:
        return const Color(0xFFEE61CF);
      case ButtonCategory.inCome:
        return const Color(0xFF000000);
    }
  }

  String get route {
    switch (this) {
      case ButtonCategory.month:
        return AppScreens.monthlyScreen;
      case ButtonCategory.week:
        return AppScreens.weeklyScreen;
      case ButtonCategory.day:
        return AppScreens.dailyScreen;
      case ButtonCategory.inCome:
        return AppScreens.allEntries;
    }
  }
}

class ExpenseCategory {
  final ButtonCategory category;
  final int amount;
  const ExpenseCategory({
    required this.category,
    required this.amount,
  });
}

class ExpenseCategoryWithPercent {
  final ButtonCategory category;
  final int amount;
  final int percent;
  const ExpenseCategoryWithPercent({
    required this.category,
    required this.amount,
    required this.percent,
  });

  static List<ExpenseCategoryWithPercent> fromList(
      List<ExpenseCategory> event) {
    final statistics = MonthlyStatistics.fromList(event);
    final date = DateTime.now();
    final days =
        DateSpecific.dayNumberForMonth(year: date.year, month: date.month);
    final int allowedPerDay = statistics.income ~/ days;
    return [
      ExpenseCategoryWithPercent(
        category: ButtonCategory.day,
        amount: statistics.day,
        percent: (allowedPerDay * 100).div(statistics.day),
      ),
      ExpenseCategoryWithPercent(
        category: ButtonCategory.week,
        amount: statistics.week,
        percent: (allowedPerDay * 7 * 100).div(statistics.week),
      ),
      ExpenseCategoryWithPercent(
        category: ButtonCategory.month,
        amount: statistics.month,
        percent: (statistics.month * 100).div(statistics.income),
      ),
      ExpenseCategoryWithPercent(
        category: ButtonCategory.inCome,
        amount: statistics.income,
        percent: statistics.income - statistics.month,
      ),
    ];
  }
}

class MonthlyStatistics {
  final int income;
  final int day;
  final int week;
  final int month;
  MonthlyStatistics({
    required this.income,
    required this.day,
    required this.week,
    required this.month,
  });

  factory MonthlyStatistics.fromList(List<ExpenseCategory> event) =>
      MonthlyStatistics(
        income: event
            .firstWhere((element) => element.category == ButtonCategory.inCome)
            .amount,
        day: event
            .firstWhere((element) => element.category == ButtonCategory.day)
            .amount,
        week: event
            .firstWhere((element) => element.category == ButtonCategory.week)
            .amount,
        month: event
            .firstWhere((element) => element.category == ButtonCategory.month)
            .amount,
      );
}
