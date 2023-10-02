//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/configuration/routing/app_screens.dart';
import 'package:house_app/core/domian/models/week_expnces.dart';
import 'package:house_app/core/domian/usecases/date_formatter.dart';
import 'package:house_app/core/extensions/build_context_extension.dart';
import 'package:house_app/dependancy_injection.dart' as di;

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

  Widget _buildWeeksList(BuildContext context, List<WeekExpnces> weeks) {
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

  final WeekExpnces week;

  @override
  Widget build(BuildContext context) {
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
                  // week.expenses > 0 ?
                  Text(
                    '${AppFormatter().currency(week.expenses)} ${context.currency}',
                    style: context.textTheme.titleMedium?.copyWith(),
                  )
                  // : const SizedBox.shrink(),
                ],
              ),
              Row(
                children: [
                  Text(
                    '',
                    style: context.textTheme.titleMedium?.copyWith(),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
