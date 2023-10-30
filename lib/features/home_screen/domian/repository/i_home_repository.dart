//

import 'package:house_app/core/domian/models/daily_spending.dart';
import 'package:house_app/features/home_screen/domian/models/monthly_statistics.dart';

import '../models/button_category.dart';

abstract class IHomeRepository {
  Future<List<ExpenseCategoryWithPercent>> fetchData();
  Stream<MonthlyStatistics> subcribe();
  Future<List<DailySpending>> sumDayInEntries();
  Future dispose();
}
