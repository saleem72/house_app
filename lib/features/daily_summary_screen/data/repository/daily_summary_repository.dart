//

import 'package:house_app/core/data/local_db/app_database.dart';
import 'package:house_app/core/data/local_db/daos/entry_dao/entry_dao.dart';
import 'package:house_app/core/data/mappers/entry_mapper.dart';
import 'package:house_app/core/domain/models/entry.dart';

import '../../domain/repository/i_daily_summary_repository.dart';

class DialySummaryRepository implements IDailySummaryRepository {
  final EntryDAO _dao;
  final EntryMapper _mapper;

  DialySummaryRepository({required AppDatabase db, required EntryMapper mapper})
      : _dao = db.entryDAO,
        _mapper = mapper;
  @override
  Future<List<Entry>> fetchData(DateTime date) async {
    final entities = await _dao.getDailyExpenses(date);
    final data = entities.map((e) => _mapper(e)).toList();
    return data;
  }
}
