//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/domain/models/daily_spending.dart';
import 'package:house_app/core/domain/models/entry.dart';
import 'package:house_app/core/domain/models/week_expenses.dart';
import 'package:house_app/core/domain/use_cases/date_formatter.dart';
import 'package:house_app/core/extensions/build_context_extension.dart';
import 'package:house_app/core/presentation/widgets/entries_grid.dart';
import 'package:house_app/core/presentation/widgets/linear_progress.dart';
import 'package:house_app/features/all_entries_screen/presentation/all_entries_bloc/all_entries_bloc.dart';

class AllEntriesScreen extends StatelessWidget {
  const AllEntriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //
      create: (context) => AllEntriesBloc()..add(AllEntriesFetchDataEvent()),
      child: const _AllEntriesScreen(),
    );
  }
}

class _AllEntriesScreen extends StatelessWidget {
  const _AllEntriesScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Entries'),
        actions: [
          IconButton(
            onPressed: () =>
                context.read<AllEntriesBloc>().add(AllEntriesFixDatesEvent()),
            icon: const Icon(Icons.update),
          ),
        ],
      ),
      body: BlocBuilder<AllEntriesBloc, AllEntriesState>(
        builder: (context, state) {
          return switch (state) {
            AllEntriesInitial() => _empty(context),
            AllEntriesLoading() =>
              const Center(child: CircularProgressIndicator()),
            AllEntriesSuccess() => _buildIncome(context, state.entries),
            AllEntriesSpending() => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    AllEntriesLinearProgressBar(),
                  ],
                ),
              ),
            AllEntriesDailySpending() =>
              _buildDailySpending(context, state.spending),
            AllEntriesMonthExpenses() =>
              _buildMonthExpenses(context, state.expenses),
          };
        },
      ),
    );
  }

  Widget _buildIncome(BuildContext context, List<Entry> entries) {
    // final formatter = AppFormatter();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: EntriesGrid(
        entries: entries,
        showDate: true,
        onDeletion: (entry) {
          context
              .read<AllEntriesBloc>()
              .add(AllEntriesDeleteEntryEvent(entry: entry));
        },
      ),
    );
  }

  Widget _empty(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            context.read<AllEntriesBloc>().add(
                  AllEntriesInsertListForMonthEvent(
                    date: DateTime(2023, 9, 30),
                  ),
                );
          },
          child: const Row(
            children: [
              Icon(Icons.add_alarm),
              SizedBox(width: 8),
              Text('Add records for month 9')
            ],
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {
            context.read<AllEntriesBloc>().add(
                  AllEntriesInsertListForMonthEvent(
                    date: DateTime(2023, 10, 31),
                  ),
                );
          },
          child: const Row(
            children: [
              Icon(Icons.add_alarm),
              SizedBox(width: 8),
              Text('Add records for month 10')
            ],
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {
            context.read<AllEntriesBloc>().add(
                  AllEntriesInsertListForMonthEvent(
                    date: DateTime.now(),
                  ),
                );
          },
          child: const Row(
            children: [
              Icon(Icons.add_alarm),
              SizedBox(width: 8),
              Text('Add records for month 11')
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDailySpending(
      BuildContext context, List<DailySpending> spending) {
    return ListView.builder(
      itemCount: spending.length,
      itemBuilder: (BuildContext context, int index) {
        final day = spending[index];
        return Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                day.day.toString(),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                day.spending.toString(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMonthExpenses(
      BuildContext context, List<WeekExpenses> expenses) {
    return SingleChildScrollView(
      child: Column(
        children: [...expenses.map((e) => _buildWeek(context, e))],
      ),
    );
  }

  Widget _buildWeek(BuildContext context, WeekExpenses week) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Row(
        children: [
          Text('${context.translate.week} ${week.index}'),
          Expanded(
              child: Column(
            children: [
              ...week.days.map((e) => Text(
                  AppFormatter().dayOfDate(e.date) + e.date.day.toString()))
            ],
          )),
          Text(week.expenses.toString()),
        ],
      ),
    );
  }
}

class AllEntriesLinearProgressBar extends StatelessWidget {
  const AllEntriesLinearProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllEntriesBloc, AllEntriesState>(
      builder: (context, state) {
        return state is AllEntriesSpending
            ? LinearProgressBar(
                percent: state.spends.toInt(),
                borderWidth: 10,
              )
            : const SizedBox.shrink();
      },
    );
  }
}
