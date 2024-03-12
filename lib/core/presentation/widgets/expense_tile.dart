//

import 'package:flutter/material.dart';
import 'package:house_app/core/domain/models/entry.dart';
import 'package:house_app/core/domain/use_cases/date_formatter.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({
    super.key,
    required this.index,
    required this.entry,
    required this.showDate,
  });
  final int index;
  final Entry entry;
  final bool showDate;
  @override
  Widget build(BuildContext context) {
    const rowStyle = TextStyle(fontSize: 16);
    return Container(
      height: 40,
      // padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(
          width: 0.5,
          color: Colors.grey,
        )),
      ),
      child: Row(
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
          if (showDate)
            Expanded(
              child: Text(
                AppFormatter().date(entry.date),
                style: rowStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}
