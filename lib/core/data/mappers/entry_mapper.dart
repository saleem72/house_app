//

import 'package:house_app/core/data/local_db/app_database.dart';
import 'package:house_app/core/domian/models/entry.dart';
import 'package:house_app/core/extensions/date_time_extension.dart';

class EntryMapper {
  Entry call(EntryEntity entity) => Entry(
        id: entity.id,
        date: entity.date.fromDrift(), // .fromDrift()
        amount: entity.amount,
        description: entity.description,
        isIncome: entity.isIncome,
      );
}
