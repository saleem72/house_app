//

import 'package:drift/drift.dart';

@DataClassName("EntryEntity")
class Entries extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  IntColumn get amount => integer()();
  TextColumn get description => text()();
  BoolColumn get isIncome => boolean().withDefault(const Constant(false))();
}
