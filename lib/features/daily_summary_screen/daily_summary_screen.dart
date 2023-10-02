//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/domian/models/entry.dart';
import 'package:house_app/core/domian/usecases/date_formatter.dart';
import 'package:house_app/core/presentation/widgets/core_widgets.dart';
import 'package:house_app/dependancy_injection.dart' as di;
import 'package:house_app/features/daily_summary_screen/presentation/daily_summary_bloc/daily_summary_bloc.dart';

class DailySummaryScreen extends StatelessWidget {
  const DailySummaryScreen({
    super.key,
    required this.date,
  });
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DailySummaryBloc(repository: di.locator())
        ..add(DailySummaryFetchDateEvent(date: date)),
      child: _DailySummaryScreen(
        date: date,
      ),
    );
  }
}

class _DailySummaryScreen extends StatelessWidget {
  const _DailySummaryScreen({
    // super.key,
    required this.date,
  });
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppFormatter().date(date)),
      ),
      body: BlocBuilder<DailySummaryBloc, DailySummaryState>(
        builder: (context, state) {
          return switch (state) {
            DailySummaryInitial() => const Column(),
            DailySummaryLoading() =>
              const Center(child: CircularProgressIndicator()),
            DailySummarySuccess() => _buildEntriesList(state.entries),
          };
        },
      ),
    );
  }

  Widget _buildEntriesList(List<Entry> entries) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
              child: EntrisGrid(
            entries: entries,
            onDeletion: (entry) {},
          )),
        ],
      ),
    );
  }
}
