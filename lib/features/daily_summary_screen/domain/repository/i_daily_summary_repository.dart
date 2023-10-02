//

import 'package:house_app/core/domian/models/entry.dart';

abstract class IDailySummaryRepository {
  Future<List<Entry>> fetchData(DateTime date);
}
