//

import 'package:flutter/material.dart';
import 'package:house_app/configuration/routing/app_screens.dart';

enum ButtonCategory {
  month,
  week,
  day;

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
