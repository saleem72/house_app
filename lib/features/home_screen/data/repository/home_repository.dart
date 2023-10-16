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
  final StreamController<List<ExpenseCategoryWithPercent>> _controller =
      StreamController<List<ExpenseCategoryWithPercent>>.broadcast();
  HomeRepository({
    required AppDatabase db,
  }) : _dao = db.entryDAO;

  @override
  Future<List<ExpenseCategoryWithPercent>> fetchData() async {
    // final temp = await _dao.summary();

    return [];
  }

  @override
  Stream<List<ExpenseCategoryWithPercent>> subcribe() {
    _subscription = _dao.watchStatistics().listen((event) {
      final data = ExpenseCategoryWithPercent.fromList(event);
      _controller.sink.add(data);
    }, onError: (error) {
      print(error.toString());
    });
    return _controller.stream;
  }

  @override
  Future dispose() async {
    await _subscription?.cancel();
    await _controller.close();
  }
}
