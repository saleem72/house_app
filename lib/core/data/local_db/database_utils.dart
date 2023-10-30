//

import 'dart:math';

import 'package:house_app/core/data/local_db/app_database.dart';

class DatabaseUtils {
  static List<EntriesCompanion> basicEntries() {
    List<EntriesCompanion> data = [];

    for (var i = 0; i < 100; i++) {
      final temp = EntriesCompanion.insert(
        date: AppRandoms.randomDate(),
        amount: AppRandoms.randomInt(),
        description: 'This Description for item: $i',
      );

      data.add(temp);
    }

    return data;
  }
}

class AppRandoms {
  AppRandoms._internal();

  static DateTime randomDate({int back = 100}) {
    var days = Random().nextInt(back);

    final endDate = DateTime.now();
    final randomDate = endDate.add(Duration(days: -days));
    return randomDate;
  }

  static int randomInt({int from = 2000, int to = 15000}) {
    var num = Random().nextInt(to - from) + from;

    return num;
  }
}
