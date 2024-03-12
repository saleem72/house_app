//

import 'package:house_app/core/domain/models/entry.dart';

abstract class IDailySummaryRepository {
  Future<List<Entry>> fetchData(DateTime date);
}
