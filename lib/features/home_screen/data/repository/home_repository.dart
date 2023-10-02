// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'dart:async';

import 'package:house_app/core/data/local_db/app_database.dart';
import 'package:house_app/core/data/local_db/daos/entry_dao/entry_dao.dart';

import '../../domian/models/button_category.dart';
import '../../domian/repository/i_home_repository.dart';

class HomeRepository implements IHomeRepository {
  final EntryDAO _dao;

  StreamSubscription<List<ExpenseCategory>>? _subscription;
  final StreamController<List<ExpenseCategory>> _controller =
      StreamController<List<ExpenseCategory>>.broadcast();
  HomeRepository({
    required AppDatabase db,
  }) : _dao = db.entryDAO;

  @override
  Future<List<ExpenseCategory>> fetchData() async {
    // final temp = await _dao.summary();

    return [];
  }

  @override
  Stream<List<ExpenseCategory>> subcribe() {
    _subscription = _dao.watchStatistics().listen((event) {
      _controller.sink.add(event);
    });
    return _controller.stream;
  }

  @override
  Future dispose() async {
    await _subscription?.cancel();
    await _controller.close();
  }
}
