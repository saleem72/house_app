//

import 'package:house_app/core/domian/models/entry.dart';

abstract class IDailyRepository {
  Future<List<Entry>> fetchData(DateTime date);
  Stream<List<Entry>> subscribe(DateTime date);
  Future dispose();
  Future deleteEntry({required Entry entry});
}
