//

class DailySpending {
  final DateTime date;
  final int spendings;

  DailySpending({
    required this.date,
    required this.spendings,
  });

  int get day => date.day;
}
