//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/domian/models/date_summary.dart';
import 'package:house_app/core/domian/models/week_expnces.dart';
import 'package:house_app/core/extensions/build_context_extension.dart';
import 'package:house_app/core/presentation/widgets/app_date_picker.dart';
import 'package:house_app/dependancy_injection.dart' as di;
import 'package:house_app/features/weekly_screen/presentation/bloc/weekly_bloc.dart';

import 'weekly_widgets.dart';

class WeeklyScreen extends StatelessWidget {
  const WeeklyScreen({super.key, this.week});
  final WeekExpnces? week;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeeklyBloc(
        repository: di.locator(),
        week: week,
      )..add(WeekFetchDataEvent()),
      child: const _WeeklyScreen(),
    );
  }
}

class _WeeklyScreen extends StatelessWidget {
  const _WeeklyScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate.week),
        actions: [
          AppDatePicker(
            onChange: (date) => context
                .read<WeeklyBloc>()
                .add(WeekFetchDataForDateEvent(date: date)),
          ),
        ],
      ),
      body: BlocBuilder<WeeklyBloc, WeeklyState>(
        builder: (context, state) {
          return switch (state) {
            WeeklyInitial() => const SizedBox.shrink(),
            WeeklyLoading() => const Center(child: CircularProgressIndicator()),
            WeeklySuccess() => _buildWeek(context, state.entries),
          };
        },
      ),
    );
  }

  Widget _buildWeek(BuildContext context, List<DateSummary> entries) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      padding: const EdgeInsets.all(16),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        final entry = entries[index];
        return DateSummaryCard(entry: entry);
      },
    );
  }
}
