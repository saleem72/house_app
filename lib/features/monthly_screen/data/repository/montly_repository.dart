//

import 'package:house_app/core/data/local_db/app_database.dart';
import 'package:house_app/core/data/local_db/daos/entry_dao/entry_dao.dart';
import 'package:house_app/core/domian/models/week_expnces.dart';
import 'package:house_app/features/monthly_screen/domain/repository/i_montly_repository.dart';

class MonthlyRepository extends IMonthlyRepository {
  final EntryDAO _dao;
  MonthlyRepository({
    required AppDatabase db,
  }) : _dao = db.entryDAO;
  @override
  Future<List<WeekExpnces>> fetchData() async {
    final date = DateTime.now();
    final data = await _dao.monthWeeksExpenses(date.year, date.month);

    return data;
  }
}
