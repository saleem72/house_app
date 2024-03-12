// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:equatable/equatable.dart';

class DateSummary extends Equatable {
  final DateTime date;
  final int amount;

  const DateSummary({
    required this.date,
    required this.amount,
  });

  @override
  List<Object?> get props => [date];
}
