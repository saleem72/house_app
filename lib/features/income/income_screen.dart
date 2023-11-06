//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/domian/models/entry.dart';
import 'package:house_app/core/extensions/build_context_extension.dart';
import 'package:house_app/core/presentation/widgets/add_new_entry_dialog.dart';
import 'package:house_app/core/presentation/widgets/entris_grid.dart';
import 'package:house_app/dependancy_injection.dart' as di;

import 'presentation/income_bloc/income_bloc.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          IncomeBloc(repository: di.locator())..add(IncomeSubscribeEvent()),
      child: const IncomeScreenContent(),
    );
  }
}

class IncomeScreenContent extends StatelessWidget {
  const IncomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate.income),
      ),
      body: _mainContent(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _dialogBuilder(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _mainContent(BuildContext context) {
    return BlocBuilder<IncomeBloc, IncomeState>(
      builder: (context, state) {
        return _content(context, state.entries);
      },
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
              child: EntrisGrid(
            entries: entries,
            // onDeletion: (entry) {},
            onDeletion: (entry) => context
                .read<IncomeBloc>()
                .add(IncomeDeleteEntryEvent(entry: entry)),
          )),
        ],
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    // final date = context.read<HomeBloc>().date;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AddNewEntryProvider(
          initialDate: DateTime.now(),
          isIncome: true,
        );
      },
    );
  }
}
