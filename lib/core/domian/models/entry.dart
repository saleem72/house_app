//

import 'package:equatable/equatable.dart';

class Entry extends Equatable {
  final int id; //  => integer().autoIncrement()();
  final DateTime date; //  => dateTime()();
  final int amount; //  => integer()();
  final String description; //  => text()();
  final bool isIncome;

  const Entry({
    required this.id,
    required this.date,
    required this.amount,
    required this.description,
    required this.isIncome,
  });

  @override
  List<Object?> get props => [
        id,
        date,
        amount,
        description,
        isIncome,
      ];
}
