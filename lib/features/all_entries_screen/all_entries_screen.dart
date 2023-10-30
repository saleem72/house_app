//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/domian/models/daily_spending.dart';
import 'package:house_app/core/presentation/widgets/linear_progress.dart';
import 'package:house_app/features/all_entries_screen/presentation/all_entries_bloc/all_entries_bloc.dart';

class AllEntriesScreen extends StatelessWidget {
  const AllEntriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AllEntriesBloc()..add(AllEntriesDailySpendingsEvent()),
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
            onPressed: () => context
                .read<AllEntriesBloc>()
                .add(AllEntriesIncreaseSpendEvent()),
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () =>
                context.read<AllEntriesBloc>().add(AllEntriesInsertListEvent()),
            icon: const Icon(Icons.add_alarm),
          ),
        ],
      ),
      body: BlocBuilder<AllEntriesBloc, AllEntriesState>(
        builder: (context, state) {
          return switch (state) {
            AllEntriesInitial() => const SizedBox.shrink(),
            AllEntriesLoading() =>
              const Center(child: CircularProgressIndicator()),
            AllEntriesSuccess() => const Column(),
            AllEntriesSpending() => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    AllEntriesLinearProgressBar(),
                  ],
                ),
              ),
            AllEntriesDailySpending() =>
              _buildDialySpendings(context, state.spendings),
          };
        },
      ),
    );
  }

  Widget _buildDialySpendings(
      BuildContext context, List<DailySpending> spendings) {
    return ListView.builder(
      itemCount: spendings.length,
      itemBuilder: (BuildContext context, int index) {
        final day = spendings[index];
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
                day.spendings.toString(),
              ),
            ),
          ],
        );
      },
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
