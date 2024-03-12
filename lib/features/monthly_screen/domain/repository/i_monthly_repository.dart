//

import 'package:house_app/core/domain/models/week_expenses.dart';

abstract class IMonthlyRepository {
  Future<List<WeekExpenses>> fetchData();
}
