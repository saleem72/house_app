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
  static DateTime randomDate() {
    var days = Random().nextInt(100);

    final endDate = DateTime.now();
    final randomDate = endDate.add(Duration(days: -days));
    return randomDate;
  }

  static int randomInt() {
    var num = Random().nextInt(20000) + 1000;

    return num;
  }
}
