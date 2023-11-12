//

import 'package:flutter/material.dart';
import 'package:house_app/core/domian/models/week_expnces.dart';
import 'package:house_app/core/domian/usecases/date_formatter.dart';
import 'package:house_app/core/extensions/build_context_extension.dart';

class WeekSummaryCard extends StatelessWidget {
  const WeekSummaryCard({
    super.key,
    required this.entry,
    required this.index,
  });

  final WeekExpnces entry;
  final int index;

  @override
  Widget build(BuildContext context) {
    // final locale = context.read<LocaleBloc>().state;
    final formatter = AppFormatter();
    return GestureDetector(
      onTap: () {
        // context.navigator
        //   .pushNamed(AppScreens.dailySummary, arguments: entry.date);
      },
      child: Card(
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
    );
  }
}
