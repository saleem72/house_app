//

import 'package:flutter/material.dart';
import 'package:house_app/configuration/routing/app_screens.dart';
import 'package:house_app/core/domain/models/week_expenses.dart';
import 'package:house_app/core/domain/use_cases/date_formatter.dart';
import 'package:house_app/core/extensions/build_context_extension.dart';

class WeekSummaryCard extends StatelessWidget {
  const WeekSummaryCard({
    super.key,
    required this.entry,
    required this.index,
  });

  final WeekExpenses entry;
  final int index;

  @override
  Widget build(BuildContext context) {
    // final locale = context.read<LocaleBloc>().state;
    final formatter = AppFormatter();
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        context.navigator.pushNamed(AppScreens.weeklyScreen, arguments: entry);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Card(
          color: Colors.white,
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          // margin: const EdgeInsets.only(bottom: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // entry.date,
                  '${context.translate.week} $index',
                ),
                Text(
                  '${formatter.currency(entry.expenses)} ${context.currency}',
                  style: context.textTheme.titleMedium?.copyWith(
                      // fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
