//

import 'package:house_app/core/domian/models/week_expnces.dart';

abstract class IMonthlyRepository {
  Future<List<WeekExpnces>> fetchData();
}
