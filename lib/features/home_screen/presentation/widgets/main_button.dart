//

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:house_app/core/domain/use_cases/date_formatter.dart';
import 'package:house_app/core/extensions/build_context_extension.dart';
import 'package:house_app/core/extensions/int_extension.dart';
import 'package:house_app/features/home_screen/domain/models/button_category.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.expense,
    this.isHistory = false,
    required this.onTap,
  });
  final Function() onTap;
  final ExpenseCategoryWithPercent? expense;
  final bool isHistory;
  @override
  Widget build(BuildContext context) {
    final formatter = AppFormatter();
    return Container(
      margin: const EdgeInsets.all(4),
      child: Material(
        color: expense?.category.color ?? Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.grey.shade300,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          isHistory
                              ? Text(
                                  'History'.toUpperCase(),
                                  style:
                                      context.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : Text(
                                  _label(context, expense!.category),
                                  style:
                                      context.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                          expense?.category == ButtonCategory.inCome
                              ? const SizedBox.shrink()
                              : Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: expense?.percent.percentColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                      child: Text(
                                    '${expense!.percent}%',
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(
                                            color: Colors.white, fontSize: 10),
                                  )),
                                )
                        ],
                      ),
                      if ((expense?.left ?? 0) > 0)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${context.translate.left}: ',
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              formatter.currency(expense?.left ?? 0),
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      isHistory
                          ? const SizedBox.shrink()
                          : Text(
                              '${formatter.currency(expense?.amount ?? 0)} ${context.currency}',
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.arrowUpRightDots,
                        color: expense?.category.accentColor ?? Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _label(BuildContext context, ButtonCategory category) {
    switch (category) {
      case ButtonCategory.day:
        return context.translate.day;
      case ButtonCategory.week:
        return context.translate.week;
      case ButtonCategory.month:
        return context.translate.month;
      case ButtonCategory.inCome:
        return context.translate.income;
    }
  }
}
