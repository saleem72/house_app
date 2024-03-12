// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:equatable/equatable.dart';

class DailySpending extends Equatable {
  final DateTime date;
  final int spending;

  const DailySpending({
    required this.date,
    required this.spending,
  });

  int get day => date.day;

  @override
  List<Object?> get props => [date, spending];
}

extension DailySpendingList on List<DailySpending> {
  double get minY => isNotEmpty
      ? reduce((value, element) =>
              value.spending < element.spending ? value : element)
          .spending
          .toDouble()
      : 1;

  double get maxY => isNotEmpty
      ? reduce((value, element) =>
              value.spending > element.spending ? value : element)
          .spending
          .toDouble()
      : 4;

  double get range => maxY - minY;
}
