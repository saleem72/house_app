//

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:house_app/core/data/local_db/daos/entry_dao/entry_dao.dart';
import 'package:house_app/core/data/local_db/entities/entry_entity.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db.sqlite')); //
    // if (file.existsSync()) {
    //   file.delete();
    // }
    return NativeDatabase(file);
  });
}

@DriftDatabase(
  tables: [
    Entries,
  ],
  daos: [
    EntryDAO,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
      onCreate: (m) async {
        await m.createAll();
        await batch((batch) {
          // batch.insertAll(entryEntity, DatabaseUtils.basicEntries());
        });
      },
    );
  }

  @override
  int get schemaVersion => 1;
}
