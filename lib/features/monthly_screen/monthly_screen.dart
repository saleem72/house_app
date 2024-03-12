//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/configuration/routing/app_screens.dart';
import 'package:house_app/core/domain/models/week_expenses.dart';
import 'package:house_app/core/domain/use_cases/date_formatter.dart';
import 'package:house_app/core/extensions/build_context_extension.dart';
import 'package:house_app/core/presentation/blocs/locale_bloc/locale_bloc.dart';
import 'package:house_app/dependency_injection.dart' as di;

import 'presentation/monthly_bloc/monthly_bloc.dart';

class MonthlyScreen extends StatelessWidget {
  const MonthlyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MonthlyBloc>(
      create: (context) => di.locator()..add(MonthlyFetchDataEvent()),
      child: const _MonthlyScreen(),
    );
  }
}

class _MonthlyScreen extends StatelessWidget {
  const _MonthlyScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate.month),
      ),
      body: BlocBuilder<MonthlyBloc, MonthlyState>(
        builder: (context, state) {
          return switch (state) {
            MonthlyInitial() => const SizedBox.shrink(),
            MonthlyLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            MonthlySuccess() => _buildWeeksList(context, state.weeks),
          };
        },
      ),
    );
  }

  Widget _buildWeeksList(BuildContext context, List<WeekExpenses> weeks) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemCount: weeks.length,
      itemBuilder: (BuildContext context, int index) {
        final week = weeks[index];
        return WeekExpansesCard(week: week);
      },
    );
  }
}

class WeekExpansesCard extends StatelessWidget {
  const WeekExpansesCard({
    super.key,
    required this.week,
  });

  final WeekExpenses week;

  @override
  Widget build(BuildContext context) {
    final locale = context.read<LocaleBloc>().state.appLang;
    return GestureDetector(
      onTap: () =>
          context.navigator.pushNamed(AppScreens.weeklyScreen, arguments: week),
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
                    '${context.translate.week_no}: ${week.index.toString()}',
                    style: context.textTheme.titleMedium?.copyWith(),
                  ),

                  Text(
                    '${AppFormatter().currency(week.expenses)} ${context.currency}',
                    style: context.textTheme.titleMedium?.copyWith(),
                  )
                  // : const SizedBox.shrink(),
                ],
              ),
              // Row(
              //   children: [
              //     Text(
              //       '',
              //       style: context.textTheme.titleMedium?.copyWith(),
              //     )
              //   ],
              // )
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    ...week.days.map((e) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppFormatter().dayOfDate(e.date, locale: locale),
                              style: context.textTheme.titleSmall?.copyWith(),
                            ),
                            Text(
                              e.amount.toString(),
                              style: context.textTheme.titleSmall?.copyWith(),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
