//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/domain/models/entry.dart';
import 'package:house_app/core/extensions/build_context_extension.dart';
import 'package:house_app/core/extensions/date_time_extension.dart';
import 'package:house_app/core/presentation/widgets/core_widgets.dart';
import 'package:house_app/dependency_injection.dart' as di;
import 'package:house_app/features/daily_screen/presentation/bloc/daily_bloc.dart';

import 'presentation/widgets/daily_linear_progress_bar.dart';

class DailyScreen extends StatelessWidget {
  const DailyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DailyBloc(repository: di.locator())..add(DailySubscribeDataEvent()),
      child: const _DailyScreen(),
    );
  }
}

class _DailyScreen extends StatelessWidget {
  const _DailyScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Row(
        //   children: [
        //     Text(context.translate.day),
        //     const SizedBox(width: 8),
        //     const ProgressCircle(percent: 20),
        //   ],
        // ),
        title: Text(context.translate.day),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: AppDatePicker(
              onChange: (date) {
                context
                    .read<DailyBloc>()
                    .add(DailyFetchDataForDateEvent(date: date));
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<DailyBloc, DailyState>(
        builder: (context, state) {
          return switch (state) {
            DailyInitial() => const Column(),
            DailyLoading() => const Center(child: CircularProgressIndicator()),
            DailySuccess() => _content(context, state.entries),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _dialogBuilder(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _content(BuildContext context, List<Entry> entries) {
    return entries.isEmpty
        ? Center(
            child: SizedBox(
              width: 200,
              child: Image.asset('assets/images/box.png'),
            ),
          )
        : _buildEntriesList(context, entries);
  }

  Widget _buildEntriesList(BuildContext context, List<Entry> entries) {
    final date = context.read<DailyBloc>().date;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          if (date.isSameDate(DateTime.now())) const DailyLinearProgressBar(),
          const SizedBox(height: 8),
          Expanded(
            child: EntriesGrid(
              entries: entries,
              onDeletion: (entry) => context
                  .read<DailyBloc>()
                  .add(DailyDeleteEntryEvent(entry: entry)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    final date = context.read<DailyBloc>().date;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AddNewEntryProvider(initialDate: date);
      },
    );
  }
}
