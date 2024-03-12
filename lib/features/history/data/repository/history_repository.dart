//

import 'package:house_app/core/data/local_db/app_database.dart';
import 'package:house_app/core/data/local_db/daos/entry_dao/entry_dao.dart';
import 'package:house_app/core/domain/models/daily_spending.dart';
import 'package:house_app/core/domain/models/month_total.dart';
import 'package:house_app/core/domain/models/week_expenses.dart';
import 'package:house_app/features/history/domain/models/history_data_model.dart';
import 'package:house_app/features/history/domain/repository/i_history_repository.dart';

class HistoryRepository implements IHistoryRepository {
  final EntryDAO _dao;

  HistoryRepository({
    required AppDatabase db,
  }) : _dao = db.entryDAO;

  Future<List<WeekExpenses>> _fetchExpnces(DateTime date) async {
    final expenses = await _dao.monthWeeksExpenses(date.year, date.month);

    return expenses;
  }

  Future<MonthTotal> _fetchStatistics(DateTime date) async {
    final data = await _dao.monthSummary(date: date);

    return data;
  }

  Future<List<DailySpending>> _sumDayInEntries({DateTime? value}) async {
    final date = value ?? DateTime.now();
    final data = await _dao.sumDayInEntries(date: date);
    if (data.isNotEmpty) {
      final lastDay = data
          .reduce((value, element) => value.day > element.day ? value : element)
          .day;
      // final firstDay = data
      //     .reduce((value, element) => value.day < element.day ? value : element)
      //     .day;
      // final firstDay = 1;
      final days = data.map((e) => e.day).toList();
      for (var i = 1; i < lastDay + 1; i++) {
        if (!days.contains(i)) {
          data.add(DailySpending(
              date: DateTime(date.year, date.month, i), spending: 0));
        }
      }
      data.sort((a, b) {
        return a.date.day.compareTo(b.date.day);
      });
      return data;
    }

    return [];
  }

  @override
  Future<HistoryDataModel> fetchData(DateTime date) async {
    final expenses = await _fetchExpnces(date);
    final statistics = await _fetchStatistics(date);
    final spendings = await _sumDayInEntries(value: date);
    return HistoryDataModel(
      expenses: expenses,
      statistics: statistics,
      dailySpendings: spendings,
    );
  }
}
