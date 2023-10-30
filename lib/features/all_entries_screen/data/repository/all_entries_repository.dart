// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:house_app/core/data/local_db/app_database.dart';
import 'package:house_app/core/data/local_db/daos/entry_dao/entry_dao.dart';
import 'package:house_app/core/data/mappers/entry_mapper.dart';
import 'package:house_app/core/domian/models/daily_spending.dart';
import 'package:house_app/core/domian/models/entry.dart';

import '../../../home_screen/domian/models/button_category.dart';

class AllEntriesRepository {
  final EntryDAO _dao;
  final EntryMapper _mapper;
  AllEntriesRepository({
    required AppDatabase db,
    required EntryMapper mapper,
  })  : _dao = db.entryDAO,
        _mapper = mapper;

  Future<List<Entry>> fetchData() async {
    final entities = await _dao.allEntries();
    final data = entities.map((e) => _mapper(e)).toList();
    return data;
  }

  Stream<List<ExpenseCategory>> stream() {
    return _dao.watchStatistics();
  }

  Future insertListOfEntries(List<Entry> entries) async {
    await _dao.insertListOfExpenses(entries);
  }

  Future<List<DailySpending>> sumDayInEntries() async {
    final data = await _dao.sumDayInEntries();
    return data;
  }
}
