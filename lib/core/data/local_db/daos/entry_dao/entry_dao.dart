//

import 'dart:math';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:house_app/core/domain/models/daily_spending.dart';
import 'package:house_app/core/domain/models/date_summary.dart';

import 'package:house_app/core/domain/models/entry.dart';
import 'package:house_app/core/domain/models/month_total.dart';
import 'package:house_app/core/domain/models/week_expenses.dart';
import 'package:house_app/core/extensions/date_time_extension.dart';
import 'package:house_app/features/home_screen/domain/models/button_category.dart';

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

  Future<int> addEntry(Entry model) async {
    final companion = EntriesCompanion(
      date: Value(model.date.toDrift()),
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
              date: Value(e.date.toDrift()),
              amount: Value(e.amount),
              description: Value(e.description),
              isIncome: Value(e.isIncome),
            ))
        .toList();

    batch((batch) => batch.insertAll(entries, companions));
  }

  Future<bool> updateEntry(Entry model) async {
    final companion = EntriesCompanion(
      id: Value(model.id),
      date: Value(model.date.toDrift()),
      amount: Value(model.amount),
      description: Value(model.description),
      isIncome: Value(model.isIncome),
    );
    final success = await update(entries).replace(companion);
    return success;
  }

  Future fixDates() async {
    List<EntryEntity> records = await select(entries).get();
    for (var record in records) {
      record = record.copyWith(date: record.date.toDrift());
    }

    batch((batch) => batch.replaceAll(entries, records));
  }

  Future deleteEntry(Entry model) async {
    final entity = await (select(entries)
          ..where((tbl) => tbl.id.equals(model.id)))
        .getSingle();
    return await delete(entries).delete(entity);
  }

  Future<List<EntryEntity>> allEntries() {
    //
    final date = DateTime.now().onlyDate().toDrift();
    return (select(entries)..where((tbl) => tbl.date.equals(date))).get();
  }

  Future<List<EntryEntity>> getExpenses() {
    var todayDate = DateTime.now();
    final firstDay = DateTime.utc(todayDate.year, todayDate.month, 1);
    return (select(entries)
          ..where((tbl) =>
              tbl.date.isBiggerOrEqualValue(firstDay) &
              tbl.isIncome.equals(false)))
        .get();
  }

  Future<List<EntryEntity>> getDailyExpenses(DateTime date) {
    // final date = value.toUtc();
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

  Stream<List<EntryEntity>> dailyExpensesStream(DateTime date) {
    // final date = value.toUtc();
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

  Future<Map<DateTime, int>> getWeeklyExpenses(DateTime date) async {
    final weekStart = date.startOfWeek().onlyDate();
    final weekEnd = date.endOfWeek().onlyDate();
    final entities = await periodEntries(weekStart, weekEnd).get();

    final result = groupBy(entities, (p0) => p0.date.onlyDate()).map(
        (key, value) => MapEntry(
            key,
            value.fold(0,
                (previousValue, element) => previousValue + element.amount)));

    return result;
  }

  //
  Stream<List<ExpenseCategory>> watchStatistics() {
    final DateTime base = DateTime.now().onlyDate();
    // final date = base.toUtc();
    // final weekStart = base.startOfWeek().toUtc();
    // final weekEnd = base.endOfWeek().toUtc();

    final date = base.toDrift();
    final weekStart = base.startOfWeek().toDrift();
    final weekEnd = base.endOfWeek().toDrift();

    final firstOfMonth = DateTime(base.year, base.month, 1).toDrift();

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

  Future<List<ExpenseCategory>> fetchStatistics(DateTime value) async {
    final DateTime base = value.onlyDate();
    final date = base.toUtc();
    final weekStart = base.startOfWeek().toUtc();
    final weekEnd = base.endOfWeek().toUtc();
    final firstOfMonth = DateTime(base.year, base.month, 1);

    final records = await customSelect(
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
    ).get();

    return records.isEmpty
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
              amount: records[0].read<int?>('daily') ?? 0,
            ),
            ExpenseCategory(
              category: ButtonCategory.week,
              amount: records[0].read<int?>('weekly') ?? 0,
            ),
            ExpenseCategory(
              category: ButtonCategory.month,
              amount: records[0].read<int?>('monthly') ?? 0,
            ),
            ExpenseCategory(
              category: ButtonCategory.inCome,
              amount: records[0].read<int?>('in_come') ?? 0,
            ),
          ];
  }

  Future<List<WeekExpenses>> monthWeeksExpenses(int year, int month) async {
    final date = DateTime(year, month, 1);
    final weeks = date.monthWeeks();
    final List<WeekExpenses> data = [];
    int i = 1;

    for (final week in weeks) {
      final entities = await periodEntries(week.first, week.last).get();

      final weekSum = entities.fold(
          0, (previousValue, element) => previousValue + element.amount);

      var newMap = groupBy(entities, (obj) => obj.date);
      final aaa = newMap
          .map(
            (key, value) => MapEntry(
              key,
              DateSummary(
                  date: key,
                  amount: value.fold(
                      0,
                      (previousValue, element) =>
                          previousValue + element.amount)),
            ),
          )
          .values
          .toList();
      aaa.sort((a, b) {
        return a.date.compareTo(b.date);
      });
      // final formatter = AppFormatter();
      // for (var aa in aaa) {
      //   print('${formatter.dayOfDate(aa.date)}\t${aa.amount}');
      // }

      final expense = WeekExpenses(
        index: i,
        days: aaa, // week.map((e) => DateSummary(date: e, amount: 0)).toList(),
        expenses: weekSum,
      );
      data.add(expense);
      i++;
    }

    return data;
  }

  Future<List<DailySpending>> sumDayInEntries({DateTime? date}) async {
    final value = date ?? DateTime.now();
    final month = value.month;
    final year = value.year;
    final sumOfDay = entries.amount.sum();

    // final query =( select(entries)
    //   ..addColumns([sumOfDay]))
    //   ..groupBy([entries.date.day]);

    final query = (select(entries)
          ..where((tbl) =>
              tbl.isIncome.equals(false) &
              tbl.date.month.equals(month) &
              tbl.date.year.equals(year)))
        .join([]);
    query
      ..addColumns([sumOfDay])
      ..groupBy([entries.date.day]);

    final result = await query.get();

    final data = result
        .map((e) => DailySpending(
            date: e.readTable(entries).date,
            spending: max(e.read(sumOfDay) ?? 0, 0)))
        .toList();
    return data;
  }

  Future<MonthTotal> monthSummary({DateTime? date}) async {
    final value = date ?? DateTime.now();
    final month = value.month;
    final year = value.year;
    final sumOfDay = entries.amount.sum();

    // final query =( select(entries)
    //   ..addColumns([sumOfDay]))
    //   ..groupBy([entries.date.day]);

    final query = (select(entries)
          ..where((tbl) {
            return tbl.date.month.equals(month) & tbl.date.year.equals(year);
          }))
        .join([]);
    query
      ..addColumns([sumOfDay])
      ..groupBy([entries.isIncome]);

    final result = await query.get();

    final data = result
        .map((e) => MonthSummaryEntry(
            isIncome: e.readTable(entries).isIncome,
            spending: max(e.read(sumOfDay) ?? 0, 0)))
        .toList();
    final newData = MonthTotal(
        date: value,
        income: data
                .firstWhereOrNull((element) => element.isIncome == true)
                ?.spending ??
            0,
        spending: data
                .firstWhereOrNull((element) => element.isIncome == false)
                ?.spending ??
            0);
    return newData;
  }

  Stream<List<EntryEntity>> monthlyIncomeStream() {
    final date = DateTime.now();
    return (select(entries)
          ..where((tbl) {
            final tblDate = tbl.date;
            return tblDate.year.equals(date.year) &
                tblDate.month.equals(date.month) &
                tbl.isIncome.equals(true);
          }))
        .watch();
  }
}
