//

import 'package:house_app/core/domain/models/date_summary.dart';

class WeekExpenses {
  final int index;
  final List<DateSummary> days;
  final int expenses;

  WeekExpenses({
    required this.index,
    required this.days,
    required this.expenses,
  });
}
