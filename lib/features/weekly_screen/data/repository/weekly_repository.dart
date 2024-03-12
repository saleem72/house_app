// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:house_app/core/data/local_db/app_database.dart';
import 'package:house_app/core/data/local_db/daos/entry_dao/entry_dao.dart';
import 'package:house_app/core/domain/models/date_summary.dart';
import 'package:house_app/features/weekly_screen/domain/repository/i_weekly_repository.dart';

class WeeklyRepository implements IWeeklyRepository {
  final EntryDAO _dao;
  WeeklyRepository({
    required AppDatabase db,
  }) : _dao = db.entryDAO;
  @override
  Future<List<DateSummary>> fetchData(DateTime date) async {
    var daysMap = await _dao.getWeeklyExpenses(date);

    final result = daysMap
        .map((key, value) =>
            MapEntry(key, DateSummary(date: key, amount: value)))
        .values
        .toList();

    return result;
  }
}
