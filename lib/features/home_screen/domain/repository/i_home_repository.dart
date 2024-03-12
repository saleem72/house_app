//

import 'package:house_app/core/domain/models/daily_spending.dart';
import 'package:house_app/core/domain/models/entry.dart';
import 'package:house_app/features/home_screen/domain/models/monthly_statistics.dart';

import '../models/button_category.dart';

abstract class IHomeRepository {
  Future<List<ExpenseCategoryWithPercent>> fetchData();
  Stream<MonthlyStatistics> subscribe();
  Future<List<DailySpending>> sumDayInEntries();
  Future dispose();
  Future<List<Entry>> testData();
}
