//

import 'package:house_app/core/domain/models/date_summary.dart';

abstract class IWeeklyRepository {
  Future<List<DateSummary>> fetchData(DateTime date);
}
