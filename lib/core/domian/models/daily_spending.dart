//

import 'package:equatable/equatable.dart';

class DailySpending extends Equatable {
  final DateTime date;
  final int spendings;

  const DailySpending({
    required this.date,
    required this.spendings,
  });

  int get day => date.day;

  @override
  List<Object?> get props => [date, spendings];
}

extension DailySpendingList on List<DailySpending> {
  double get minY => isNotEmpty
      ? reduce((value, element) =>
              value.spendings < element.spendings ? value : element)
          .spendings
          .toDouble()
      : 1;

  double get maxY => isNotEmpty
      ? reduce((value, element) =>
              value.spendings > element.spendings ? value : element)
          .spendings
          .toDouble()
      : 4;

  double get range => maxY - minY;
}
