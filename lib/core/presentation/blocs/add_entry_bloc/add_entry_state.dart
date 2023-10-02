// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_entry_bloc.dart';

final class AddEntryState extends Equatable {
  final int amount;
  final String description;
  final DateTime date;
  final bool isValid;

  const AddEntryState._internal({
    required this.amount,
    required this.description,
    required this.isValid,
    required this.date,
  });

  @override
  List<Object> get props => [amount, description, isValid];

  factory AddEntryState.initail() => AddEntryState._internal(
      amount: 0, description: '', isValid: false, date: DateTime.now());

  AddEntryState copyWith({
    int? amount,
    String? description,
    bool? isValid,
    DateTime? date,
  }) {
    return AddEntryState._internal(
      amount: amount ?? this.amount,
      description: description ?? this.description,
      isValid: isValid ?? this.isValid,
      date: date ?? this.date,
    );
  }
}
