//

import 'package:house_app/core/domian/models/date_summary.dart';

class WeekExpnces {
  final int index;
  final List<DateSummary> days;
  final int expenses;

  WeekExpnces({
    required this.index,
    required this.days,
    required this.expenses,
  });
}
