//

import 'package:house_app/core/domian/models/date_summary.dart';

abstract class IWeeklyRepository {
  Future<List<DateSummary>> fetchData(DateTime date);
}
