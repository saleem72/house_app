//

import 'dart:async';

import 'package:house_app/core/data/local_db/app_database.dart';
import 'package:house_app/core/data/local_db/daos/entry_dao/entry_dao.dart';
import 'package:house_app/core/data/mappers/entry_mapper.dart';
import 'package:house_app/features/daily_screen/domain/repository/i_daily_repository.dart';
import 'package:house_app/core/domain/models/entry.dart';

class DailyRepository implements IDailyRepository {
  final EntryDAO _dao;
  final EntryMapper _mapper;

  StreamSubscription<List<EntryEntity>>? _subscription;
  final StreamController<List<Entry>> _controller =
      StreamController<List<Entry>>.broadcast();

  DailyRepository({
    required AppDatabase db,
    required EntryMapper mapper,
  })  : _dao = db.entryDAO,
        _mapper = mapper;

  @override
  Future<List<Entry>> fetchData(DateTime date) async {
    final entities = await _dao.getDailyExpenses(date);
    final data = entities.map((e) => _mapper(e)).toList();
    return data;
  }

  @override
  Stream<List<Entry>> subscribe(DateTime date) {
    _subscription?.cancel();
    _subscription = _dao.dailyExpensesStream(date).listen((entities) {
      final data = entities.map((e) => _mapper(e)).toList();
      _controller.sink.add(data);
    });

    return _controller.stream;
  }

  @override
  Future dispose() async {
    _subscription?.cancel();
    _controller.close();
  }

  @override
  Future deleteEntry({required Entry entry}) {
    return _dao.deleteEntry(entry);
  }
}
