//

import 'package:flutter/material.dart';
import 'package:house_app/core/domain/models/month_total.dart';
import 'package:house_app/core/domain/use_cases/date_formatter.dart';
import 'package:house_app/core/extensions/build_context_extension.dart';

class HistoryFinanceView extends StatelessWidget {
  const HistoryFinanceView({
    super.key,
    required this.statistics,
  });
  final MonthTotal statistics;
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
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      context.translate.income,
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        context.translate.spending,
                        textAlign: TextAlign.center,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        context.translate.left,
                        textAlign: TextAlign.center,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      formatter.currency(statistics.income),
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        formatter.currency(statistics.spending),
                        textAlign: TextAlign.center,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          // fontWeight: FontWeight.w600,
                        ),
                      ),
                    )),
                Expanded(
                  flex: 2,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      formatter.currency(statistics.left),
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontSize: 18,
                        // fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
