//

import 'dart:async';

import 'package:house_app/core/data/local_db/app_database.dart';
import 'package:house_app/core/data/local_db/daos/entry_dao/entry_dao.dart';
import 'package:house_app/core/data/mappers/entry_mapper.dart';
import 'package:house_app/core/domian/models/entry.dart';
import 'package:house_app/features/income/domain/repository/i_income_repository.dart';

class IncomeRepository implements IIncomeRepository {
  final EntryDAO _dao;
  final EntryMapper _mapper;

  StreamSubscription<List<EntryEntity>>? _subscription;
  final StreamController<List<Entry>> _controller =
      StreamController<List<Entry>>.broadcast();

  IncomeRepository({
    required AppDatabase db,
    required EntryMapper mapper,
  })  : _dao = db.entryDAO,
        _mapper = mapper;

  @override
  Stream<List<Entry>> subscribe() {
    _subscription?.cancel();
    _subscription = _dao.monthlyIncomeStraem().listen((entities) {
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

  @override
  Future updateEntry({required Entry entry}) async {}
}
