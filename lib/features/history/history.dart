//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/extensions/build_context_extension.dart';
import 'package:house_app/dependancy_injection.dart' as di;
import 'package:house_app/features/history/presentation/history_bloc/history_bloc.dart';
import 'package:house_app/features/history/presentation/widgets/history_finance_view.dart';
import 'package:house_app/features/home_screen/presentation/widgets/monthly_chart.dart';

import 'presentation/widgets/history_date_picker.dart';
import 'presentation/widgets/week_summary_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.locator<HistoryBloc>()..add(HistoryFetchDataEvent()),
      child: const HistoryScreenContent(),
    );
  }
}

class HistoryScreenContent extends StatelessWidget {
  const HistoryScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate.history),
        actions: [
          HistoryDatePicker(
            onDateChange: (date) => context
                .read<HistoryBloc>()
                .add(HistoryDateChangedEvent(date: date)),
          ),
        ],
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          return _content(context, state);
        },
      ),
    );
  }

  Widget _content(BuildContext context, HistoryState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: HistoryFinanceView(statistics: state.statistics),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: _buildChart(state),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: _buildWeek(state),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChart(HistoryState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      // padding: const EdgeInsets.only(top: 8),
      child: Material(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding:
              const EdgeInsets.only(top: 32, left: 8, right: 8, bottom: 48),
          child: MonthlyChart(status: state.dailySpendings),
        ),
      ),
    );
  }

  Widget _buildWeek(HistoryState state) {
    return Column(
      children: [
        ...state.expenses
            .asMap()
            .map(
              (key, value) => MapEntry(
                key,
                WeekSummaryCard(
                  entry: value,
                  index: key + 1,
                ),
              ),
            )
            .values
            .toList()
      ],
    );
  }
}

//
