//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/domain/models/entry.dart';
import 'package:house_app/core/domain/use_cases/date_formatter.dart';
import 'package:house_app/core/presentation/blocs/locale_bloc/locale_bloc.dart';
import 'package:house_app/core/presentation/widgets/core_widgets.dart';
import 'package:house_app/dependency_injection.dart' as di;
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
    final locale = context.read<LocaleBloc>().state.appLang;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppFormatter().arabicDate(date, locale: locale)),
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
              child: EntriesGrid(
            entries: entries,
            onDeletion: (entry) {},
          )),
        ],
      ),
    );
  }
}
