//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/domian/models/entry.dart';
import 'package:house_app/core/domian/usecases/date_formatter.dart';
import 'package:house_app/core/extensions/build_context_extension.dart';
import 'package:house_app/features/all_entries_screen/presentation/all_entries_bloc/all_entries_bloc.dart';

class AllEntriesScreen extends StatelessWidget {
  const AllEntriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
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
      ),
      body: BlocBuilder<AllEntriesBloc, AllEntriesState>(
        builder: (context, state) {
          final stream = context.read<AllEntriesBloc>().repository.stream();
          return switch (state) {
            AllEntriesInitial() => const SizedBox.shrink(),
            AllEntriesLoading() =>
              const Center(child: CircularProgressIndicator()),
            AllEntriesSuccess() => Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: EnhancedEntrisGrid(entries: state.entries),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: stream,
                      initialData: const [],
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        final data = snapshot.data ?? [];
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = data[index];
                            return Row(
                              children: [
                                Text(item.category.label),
                                Text(item.amount.toString())
                              ],
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
          };
        },
      ),
    );
  }
}

class EnhancedEntrisGrid extends StatelessWidget {
  const EnhancedEntrisGrid({
    super.key,
    required this.entries,
  });

  final List<Entry> entries;

  @override
  Widget build(BuildContext context) {
    final total = entries.fold(
        0, (previousValue, element) => previousValue + element.amount);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                final entry = entries[index];
                return _buildEntry(entry, index + 1);
              },
            ),
          ),
          SizedBox(
            height: 32,
            child: Row(
              children: [
                Text(
                  'Total: ${AppFormatter().currency(total)}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final headerStyle = context.textTheme.titleMedium?.copyWith(
      fontStyle: FontStyle.italic,
    );

    return Container(
      height: 32,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(
              '#',
              style: headerStyle,
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              context.translate.amount,
              style: headerStyle,
            ),
          ),
          Expanded(
            child: Text(
              context.translate.description,
              style: headerStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEntry(Entry entry, int index) {
    const rowStyle = TextStyle(fontSize: 16);
    return Container(
      // height: 32,
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(
          width: 0.5,
          color: Colors.grey,
        )),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 30,
                child: Text(
                  index.toString(),
                  style: rowStyle,
                ),
              ),
              SizedBox(
                width: 100,
                child: Text(
                  AppFormatter().currency(entry.amount),
                  style: rowStyle,
                ),
              ),
              Expanded(
                child: Text(
                  entry.description,
                  style: rowStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Text(entry.date.toString())
        ],
      ),
    );
  }
}
