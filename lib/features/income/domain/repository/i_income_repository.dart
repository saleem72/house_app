//

import 'package:house_app/core/domain/models/entry.dart';

abstract class IIncomeRepository {
  Stream<List<Entry>> subscribe();
  Future dispose();
  Future deleteEntry({required Entry entry});
  Future updateEntry({required Entry entry});
}
