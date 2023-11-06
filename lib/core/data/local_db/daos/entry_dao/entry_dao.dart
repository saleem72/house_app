// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'dart:math';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:house_app/core/domian/models/daily_spending.dart';

import 'package:house_app/core/domian/models/entry.dart';
import 'package:house_app/core/domian/models/week_expnces.dart';
import 'package:house_app/core/extensions/date_time_extension.dart';
import 'package:house_app/features/home_screen/domian/models/button_category.dart';

import '../../app_database.dart';
import '../../entities/entry_entity.dart';

part 'entry_dao.g.dart';

@DriftAccessor(
  tables: [Entries],
  queries: {
    'dayEntries':
        'SELECT SUM(amount) AS c FROM entries WHERE date = ? GROUP BY date',
    'periodEntries':
        'SELECT * FROM entries WHERE is_income = 0 AND date BETWEEN ? AND ?',
  },
)
class EntryDAO extends DatabaseAccessor<AppDatabase> with _$EntryDAOMixin {
  EntryDAO(AppDatabase db) : super(db);

  Future<List<EntryEntity>> allEntries() {
    return select(entries).get();
  }

  Future<List<EntryEntity>> getExpences() {
    var todayDate = DateTime.now();
    final firstday = DateTime.utc(todayDate.year, todayDate.month, 1);
    return (select(entries)
          ..where((tbl) =>
              tbl.date.isBiggerOrEqualValue(firstday) &
              tbl.isIncome.equals(false)))
        .get();
  }

  Future<List<EntryEntity>> getDailyExpences(DateTime value) {
    final date = value.toUtc();
    return (select(entries)
          ..where((tbl) {
            final tblDate = tbl.date;
            return tblDate.year.equals(date.year) &
                tblDate.month.equals(date.month) &
                tblDate.day.equals(date.day) &
                tbl.isIncome.equals(false);
          }))
        .get();
  }

  Stream<List<EntryEntity>> dailyExpencesStraem(DateTime value) {
    final date = value.toUtc();
    return (select(entries)
          ..where((tbl) {
            final tblDate = tbl.date;
            return tblDate.year.equals(date.year) &
                tblDate.month.equals(date.month) &
                tblDate.day.equals(date.day) &
                tbl.isIncome.equals(false);
          }))
        .watch();
  }

  Future<Map<DateTime, int>> getWeeklyExpences(DateTime date) async {
    final weekStart = date.startOfWeek().onlyDate().toUtc();
    final weekEnd = date.endOfWeek().onlyDate().toUtc();
    final entities = await periodEntries(weekStart, weekEnd).get();
    // final entities = await (select(entries)
    //       ..where((tbl) =>
    //           tbl.date.isBetweenValues(weekStart, weekEnd) &
    //           tbl.isIncome.equals(false)))
    //     .get();

    final result = groupBy(entities, (p0) => p0.date.onlyDate()).map(
        (key, value) => MapEntry(
            key,
            value.fold(0,
                (previousValue, element) => previousValue + element.amount)));

    return result;
  }

  Future<bool> updateEntry(Entry model) async {
    final companion = EntriesCompanion(
      id: Value(model.id),
      date: Value(model.date),
      amount: Value(model.amount),
      description: Value(model.description),
      isIncome: Value(model.isIncome),
    );
    final success = await update(entries).replace(companion);
    return success;
  }

  //
  Stream<List<ExpenseCategory>> watchStatistics() {
    final DateTime base = DateTime.now().onlyDate();
    final date = base.toUtc();
    final weekStart = base.startOfWeek().toUtc();
    final weekEnd = base.endOfWeek().toUtc();
    final firstOfMonth = DateTime(base.year, base.month, 1);

    return customSelect(
      '''SELECT 
            (SELECT SUM(amount) FROM entries WHERE date = ?1 AND is_income = false) AS "daily", 
            (SELECT SUM(amount) FROM entries WHERE date BETWEEN ?2 AND ?3 AND is_income = false) AS "weekly", 
            (SELECT SUM(amount) FROM entries WHERE date BETWEEN ?4 AND ?5 AND is_income = false) AS "monthly",
            (SELECT SUM(amount) FROM entries WHERE date BETWEEN ?6 AND ?7 AND is_income = true) AS "in_come"
          FROM entries;''',
      variables: [
        Variable<DateTime>(date),
        Variable<DateTime>(weekStart),
        Variable<DateTime>(weekEnd),
        Variable<DateTime>(firstOfMonth),
        Variable<DateTime>(date),
        Variable<DateTime>(firstOfMonth),
        Variable<DateTime>(date),
      ],
      readsFrom: {
        entries,
      },
    ).watch().map((event) {
      return event.isEmpty
          ? const <ExpenseCategory>[
              ExpenseCategory(
                category: ButtonCategory.day,
                amount: 0,
              ),
              ExpenseCategory(
                category: ButtonCategory.week,
                amount: 0,
              ),
              ExpenseCategory(
                category: ButtonCategory.month,
                amount: 0,
              ),
              ExpenseCategory(
                category: ButtonCategory.inCome,
                amount: 0,
              ),
            ]
          : <ExpenseCategory>[
              ExpenseCategory(
                category: ButtonCategory.day,
                amount: event[0].read<int?>('daily') ?? 0,
              ),
              ExpenseCategory(
                category: ButtonCategory.week,
                amount: event[0].read<int?>('weekly') ?? 0,
              ),
              ExpenseCategory(
                category: ButtonCategory.month,
                amount: event[0].read<int?>('monthly') ?? 0,
              ),
              ExpenseCategory(
                category: ButtonCategory.inCome,
                amount: event[0].read<int?>('in_come') ?? 0,
              ),
            ];
    });
  }

  Future<List<WeekExpnces>> monthWeeksExpenses() async {
    final date = DateTime.now();
    final weeks = date.monthWeaks();
    final List<WeekExpnces> data = [];
    int i = 1;
    for (final week in weeks) {
      final entities = await periodEntries(week.first, week.last).get();
      final weekSum = entities.fold(
          0, (previousValue, element) => previousValue + element.amount);
      final expense = WeekExpnces(
        index: i,
        days: week,
        expenses: weekSum,
      );
      data.add(expense);
      i++;
    }

    return data;
  }

  Future deleteEntry(Entry model) async {
    final entity = await (select(entries)
          ..where((tbl) => tbl.id.equals(model.id)))
        .getSingle();
    return await delete(entries).delete(entity);
  }

  Future<int> addEntry(Entry model) async {
    final companion = EntriesCompanion(
      date: Value(model.date),
      amount: Value(model.amount),
      description: Value(model.description),
      isIncome: Value(model.isIncome),
    );
    final id = await into(entries).insert(companion);
    return id;
  }

  Future insertListOfExpenses(List<Entry> list) async {
    final companions = list
        .map((e) => EntriesCompanion(
              date: Value(e.date),
              amount: Value(e.amount),
              description: Value(e.description),
              isIncome: Value(e.isIncome),
            ))
        .toList();

    batch((batch) => batch.insertAll(entries, companions));
  }

  Future<List<DailySpending>> sumDayInEntries() async {
    final month = DateTime.now().month;
    final sumOfDay = entries.amount.sum();

    // final query =( select(entries)
    //   ..addColumns([sumOfDay]))
    //   ..groupBy([entries.date.day]);

    final query = (select(entries)
          ..where((tbl) =>
              tbl.isIncome.equals(false) & tbl.date.month.equals(month)))
        .join([]);
    query
      ..addColumns([sumOfDay])
      ..groupBy([entries.date.day]);

    final result = await query.get();

    final data = result
        .map((e) => DailySpending(
            date: e.readTable(entries).date,
            spendings: max(e.read(sumOfDay) ?? 0, 0)))
        .toList();
    return data;
  }

  Stream<List<EntryEntity>> monthlyIncomeStraem() {
    final date = DateTime.now();
    return (select(entries)
          ..where((tbl) {
            final tblDate = tbl.date;
            return tblDate.month.equals(date.month) & tbl.isIncome.equals(true);
          }))
        .watch();
  }
}
