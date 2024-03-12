//

extension DateSpecific on DateTime {
  DateTime startOfWeek() {
    // return subtract(Duration(days: weekday - 1));

    if (weekday == DateTime.sunday) {
      return this;
    }
    var date = subtract(const Duration(days: 1));
    while (true) {
      if (date.weekday == DateTime.sunday) {
        return date;
      } else {
        date = date.subtract(const Duration(days: 1));
      }
    }
  }
  // DateTime endOfWeek() {
  //   return add(Duration(days: DateTime.daysPerWeek - weekday));
  // }

  DateTime endOfWeek({int firstDay = DateTime.sunday}) {
    // DateTime start = this;
    // while (true) {
    //   final end = start.add(const Duration(days: 1));
    //   if (end.weekday == firstDay) {
    //     return start;
    //   }
    //   start = end;
    // }

    if (weekday == DateTime.saturday) {
      return this;
    }
    var date = add(const Duration(days: 1));
    while (true) {
      if (date.weekday == DateTime.saturday) {
        return date;
      } else {
        date = date.add(const Duration(days: 1));
      }
    }
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  DateTime onlyDate() {
    return DateTime(year, month, day);
  }

  List<DateTime> wholeWeek() {
    final start = startOfWeek();
    final temp = [
      start,
    ];

    for (var i = 1; i < 7; i++) {
      final day = start.add(Duration(days: i));
      if (day.compareTo(DateTime.now()) <= 0) {
        temp.add(day);
      }
    }

    return temp;
  }

  DateTime get lastDayOfMonth =>
      month < 12 ? DateTime(year, month + 1, 0) : DateTime(year + 1, 1, 0);

  List<List<DateTime>> monthWeeks({int firstDay = DateTime.sunday}) {
    List<List<DateTime>> weeks = [];
    List<DateTime> group = [];
    final daysNum = dayNumberForMonth(year: year, month: month);
    for (var i = 1; i < daysNum + 1; i++) {
      final date = DateTime(year, month, i);
      final flag = date.weekday == firstDay;
      if (flag && group.isNotEmpty) {
        weeks.add(group.map((e) => e).toList());
        group.clear();
        group.add(date);
      } else {
        group.add(date);
      }
    }
    if (group.isNotEmpty) {
      weeks.add(group);
    }
    return weeks;
  }

  static int dayNumberForMonth({required int year, required int month}) {
    DateTime x1 = DateTime(year, month, 0).toUtc();
    int y1;
    if (month == 12) {
      y1 = DateTime(year + 1, 1, 0).toUtc().difference(x1).inDays;
    } else {
      y1 = DateTime(year, month + 1, 0).toUtc().difference(x1).inDays;
    }
    return y1;
  }

  DateTime toDrift() {
    return add(_utcDifference());
  }

  DateTime fromDrift() {
    return add(-_utcDifference());
  }

  Duration _utcDifference() {
    final date = DateTime.now();
    final local = DateTime(date.year, date.month, date.day);
    final utc = DateTime.utc(date.year, date.month, date.day);
    final dateDifference = utc.difference(local);
    final sign = dateDifference.inMinutes ~/ dateDifference.inMinutes.abs();
    final safty = dateDifference.inHours.abs() + 2;
    final result = Duration(hours: safty * sign);
    return result;
  }
}
