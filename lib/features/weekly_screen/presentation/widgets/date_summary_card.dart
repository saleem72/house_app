//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/configuration/routing/app_screens.dart';
import 'package:house_app/core/domian/models/date_summary.dart';
import 'package:house_app/core/domian/usecases/date_formatter.dart';
import 'package:house_app/core/extensions/build_context_extension.dart';
import 'package:house_app/core/presentation/blocs/locale_bloc/locale_bloc.dart';

class DateSummaryCard extends StatelessWidget {
  const DateSummaryCard({
    super.key,
    required this.entry,
  });

  final DateSummary entry;

  @override
  Widget build(BuildContext context) {
    final locale = context.read<LocaleBloc>().state;
    return GestureDetector(
      onTap: () => context.navigator
          .pushNamed(AppScreens.dailySummary, arguments: entry.date),
      child: Card(
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    // entry.date,
                    '${AppFormatter().dayOfDate(entry.date, locale: locale.appLang)} ',
                  ),
                  Text(
                    AppFormatter()
                        .arabicDate(entry.date, locale: locale.appLang),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${AppFormatter().currency(entry.amount)} ${context.currency}',
                    style: context.textTheme.titleMedium?.copyWith(
                        // fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
