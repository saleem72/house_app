//

import 'package:house_app/core/data/local_db/app_database.dart';
import 'package:house_app/core/domian/models/entry.dart';

class EntryMapper {
  Entry call(EntryEntity entity) => Entry(
        id: entity.id,
        date: entity.date,
        amount: entity.amount,
        description: entity.description,
        isIncome: entity.isIncome,
      );
}
