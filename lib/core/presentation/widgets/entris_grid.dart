//

import 'package:flutter/material.dart';
import 'package:house_app/core/domian/models/entry.dart';
import 'package:house_app/core/domian/usecases/date_formatter.dart';
import 'package:house_app/core/extensions/build_context_extension.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:house_app/core/presentation/widgets/core_widgets.dart';

import 'confirmation_alert.dart';
import 'expense_tile.dart';

class EntrisGrid extends StatelessWidget {
  const EntrisGrid({
    super.key,
    required this.entries,
    required this.onDeletion,
    this.showDate = false,
  });
  final Function(Entry) onDeletion;
  final List<Entry> entries;
  final bool showDate;
  @override
  Widget build(BuildContext context) {
    final total = entries.fold(
        0, (previousValue, element) => previousValue + element.amount);
    return Column(
      children: [
        _buildHeader(context),
        Expanded(
          child: ListView.builder(
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              final entry = entries[index];
              return _buildEntry(context, entry, index);
            },
          ),
        ),
        SizedBox(
          height: 32,
          child: Row(
            children: [
              Text(
                '${context.translate.total}: ${AppFormatter().currency(total)} ${context.currency}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    final headerStyle = context.textTheme.titleMedium?.copyWith(
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w600,
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
          if (showDate)
            Expanded(
              child: Text(
                context.translate.date,
                style: headerStyle,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEntry(BuildContext context, Entry entry, int index) {
    return Slidable(
      key: ValueKey(entry.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => _delete(context, entry),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
          SlidableAction(
            onPressed: (_) => _edit(context, entry),
            backgroundColor: const Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.edit,
          ),
        ],
      ),
      child: ExpenseTile(
        entry: entry,
        index: index + 1,
        showDate: showDate,
      ),
    );
  }

  _edit(BuildContext context, Entry entry) {
    showDialog(
      context: context,
      builder: (context) {
        return AddNewEntryProvider(
          initialDate: entry.date,
          entry: entry,
        );
      },
    );
  }

  _delete(BuildContext context, Entry entry) {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmationAlert(
          onDeletion: () => onDeletion(entry),
        );
      },
    );
  }
}
