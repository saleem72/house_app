// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'dart:async';

import 'package:house_app/core/data/local_db/app_database.dart';
import 'package:house_app/core/data/local_db/daos/entry_dao/entry_dao.dart';
import 'package:house_app/features/home_screen/domian/models/monthly_statistics.dart';

import '../../domian/models/button_category.dart';
import '../../domian/repository/i_home_repository.dart';

class HomeRepository implements IHomeRepository {
  final EntryDAO _dao;

  StreamSubscription<List<ExpenseCategory>>? _subscription;
  final StreamController<MonthlyStatistics> _controller =
      StreamController<MonthlyStatistics>.broadcast();
  HomeRepository({
    required AppDatabase db,
  }) : _dao = db.entryDAO;

  @override
  Future<List<ExpenseCategoryWithPercent>> fetchData() async {
    // final temp = await _dao.summary();

    return [];
  }

  @override
  Stream<MonthlyStatistics> subcribe() {
    _subscription = _dao.watchStatistics().listen((event) {
      // final data = ExpenseCategoryWithPercent.fromList(event);
      final data = MonthlyStatistics.fromList(event);
      _controller.sink.add(data);
    }, onError: (error) {
      // ignore: avoid_print
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
