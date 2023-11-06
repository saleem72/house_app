//

import 'package:flutter/material.dart';
import 'package:house_app/core/domian/usecases/date_formatter.dart';
import 'package:house_app/core/extensions/build_context_extension.dart';
import 'package:house_app/features/home_screen/domian/models/monthly_statistics.dart';

class MonthLeftsView extends StatelessWidget {
  const MonthLeftsView({
    super.key,
    required this.statistics,
  });

  final MonthlyStatistics statistics;

  @override
  Widget build(BuildContext context) {
    final formatter = AppFormatter();
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: 75,
        // color: Colors.white,
        // padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),

        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    context.translate.left,
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Text(
                      context.translate.day,
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: Text(
                      context.translate.amount,
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    formatter.currency(statistics.left),
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontSize: 18,
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Text(
                      statistics.daysLeft.toString(),
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontSize: 18,
                        // fontWeight: FontWeight.w600,
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: Text(
                      formatter.currency(statistics.perDay),
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontSize: 18,
                        // fontWeight: FontWeight.w600,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
