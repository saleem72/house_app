//

extension DateSpecific on DateTime {
  DateTime startOfWeek() => subtract(Duration(days: weekday - 1));
  DateTime endOfWeek() => add(Duration(days: DateTime.daysPerWeek - weekday));

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

  List<DateTime> _firstWeek() {
    final List<DateTime> result = [];
    final first = DateTime(year, month, 1);
    result.add(first);
    final firstDay = first.weekday;
    for (var i = 1; i < (7 - firstDay + 1); i++) {
      final temp = first.add(Duration(days: i));
      result.add(temp);
    }
    return result;
  }

  DateTime get lastDayOfMonth =>
      month < 12 ? DateTime(year, month + 1, 0) : DateTime(year + 1, 1, 0);

  List<DateTime> _lastWeek() {
    final List<DateTime> result = [];
    final end = lastDayOfMonth;
    final first = end.startOfWeek();
    result.add(first);
    final firstDay = first.weekday;
    for (var i = 1; i < (7 - firstDay); i++) {
      final temp = first.add(Duration(days: i));
      if (temp.compareTo(end) <= 0) {
        result.add(temp);
      }
    }
    return result;
  }

  List<DateTime> _midWeek(DateTime start, DateTime maxDate) {
    if (maxDate.compareTo(start) <= 0) {
      return [];
    }
    final List<DateTime> result = [];
    final end = maxDate;
    final first = start;
    result.add(first);
    final firstDay = first.weekday;
    for (var i = 1; i < (7 - firstDay + 1); i++) {
      final temp = first.add(Duration(days: i));
      if (temp.compareTo(end) <= 0) {
        result.add(temp);
      }
    }
    return result;
  }

  List<List<DateTime>> monthWeaks() {
    final firstWeek = _firstWeek();
    // print(firstWeek);
    final lastWeek = _lastWeek();
    // print(lastWeek);
    DateTime start = firstWeek.last.add(const Duration(days: 1));
    final end = lastWeek.first;
    final List<List<DateTime>> mids = [];
    while (true) {
      final mid = _midWeek(start, end);
      if (mid.isEmpty) {
        break;
      }
      mids.add(mid);
      start = mid.last.add(const Duration(days: 1));
    }

    final List<List<DateTime>> result = [];
    result.add(firstWeek);
    result.addAll(mids);
    result.add(lastWeek);

    return result;
  }
}
