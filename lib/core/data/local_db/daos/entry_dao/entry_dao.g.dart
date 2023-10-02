// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_dao.dart';

// ignore_for_file: type=lint
mixin _$EntryDAOMixin on DatabaseAccessor<AppDatabase> {
  $EntriesTable get entries => attachedDatabase.entries;
  Selectable<int> dayEntries(DateTime var1) {
    return customSelect(
        'SELECT SUM(amount) AS c FROM entries WHERE date = ?1 GROUP BY date',
        variables: [
          Variable<DateTime>(var1)
        ],
        readsFrom: {
          entries,
        }).map((QueryRow row) => row.read<int>('c'));
  }

  Selectable<EntryEntity> periodEntries(DateTime var1, DateTime var2) {
    return customSelect(
        'SELECT * FROM entries WHERE is_income = 0 AND date BETWEEN ?1 AND ?2',
        variables: [
          Variable<DateTime>(var1),
          Variable<DateTime>(var2)
        ],
        readsFrom: {
          entries,
        }).asyncMap(entries.mapFromRow);
  }
}
