//

import 'package:flutter/material.dart';
import 'package:house_app/configuration/routing/app_screens.dart';
import 'package:house_app/core/domian/models/week_expnces.dart';
import 'package:house_app/features/screens.dart';

import 'routing_error_screen.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case AppScreens.initial:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppScreens.monthlyScreen:
        return MaterialPageRoute(builder: (_) => const MonthlyScreen());
      case AppScreens.weeklyScreen:
        final week = settings.arguments as WeekExpnces?;
        return MaterialPageRoute(
            builder: (_) => WeeklyScreen(
                  week: week,
                ));
      case AppScreens.dailyScreen:
        return MaterialPageRoute(builder: (_) => const DailyScreen());
      case AppScreens.dailySummary:
        final date = settings.arguments as DateTime?;
        if (date == null) {
          final String errorMessage =
              'You have to provide date for ${settings.name} route';
          return MaterialPageRoute(
              builder: (_) => RoutingErrorScreen(errorMessage: errorMessage));
        }
        return MaterialPageRoute(
            builder: (_) => DailySummaryScreen(date: date));
      case AppScreens.income:
        return MaterialPageRoute(builder: (_) => const IncomeScreen());
      case AppScreens.allEntries:
        return MaterialPageRoute(builder: (_) => const AllEntriesScreen());
      case AppScreens.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case AppScreens.history:
        return MaterialPageRoute(builder: (_) => const HistoryScreen());
      default:
        final String errorMessage = '${settings.name} is not valid route';
        return MaterialPageRoute(
            builder: (_) => RoutingErrorScreen(errorMessage: errorMessage));
    }
  }
}
