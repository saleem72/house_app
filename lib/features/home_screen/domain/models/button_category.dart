//

import 'package:flutter/material.dart';

import 'package:house_app/configuration/routing/app_screens.dart';
import 'package:house_app/core/extensions/date_time_extension.dart';
import 'package:house_app/core/extensions/int_extension.dart';
import 'package:house_app/features/home_screen/domain/models/monthly_statistics.dart';

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
        return AppScreens.income;
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
  final int left;
  const ExpenseCategoryWithPercent({
    required this.category,
    required this.amount,
    required this.percent,
    required this.left,
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
        percent: (statistics.day * 100).div(allowedPerDay),
        left: 0,
      ),
      ExpenseCategoryWithPercent(
        category: ButtonCategory.week,
        amount: statistics.week,
        percent: (statistics.week * 100).div(allowedPerDay * 7),
        left: 0,
      ),
      ExpenseCategoryWithPercent(
        category: ButtonCategory.month,
        amount: statistics.month,
        percent: (statistics.month * 100).div(statistics.income),
        left: 0,
      ),
      ExpenseCategoryWithPercent(
        category: ButtonCategory.inCome,
        amount: statistics.income,
        percent: statistics.income - statistics.month,
        left: 0,
      ),
    ];
  }
}
