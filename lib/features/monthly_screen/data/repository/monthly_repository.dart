//

import 'package:house_app/core/data/local_db/app_database.dart';
import 'package:house_app/core/data/local_db/daos/entry_dao/entry_dao.dart';
import 'package:house_app/core/domain/models/week_expenses.dart';
import 'package:house_app/features/monthly_screen/domain/repository/i_monthly_repository.dart';

class MonthlyRepository extends IMonthlyRepository {
  final EntryDAO _dao;
  MonthlyRepository({
    required AppDatabase db,
  }) : _dao = db.entryDAO;
  @override
  Future<List<WeekExpenses>> fetchData() async {
    final date = DateTime.now();
    final data = await _dao.monthWeeksExpenses(date.year, date.month);

    return data;
  }
}
