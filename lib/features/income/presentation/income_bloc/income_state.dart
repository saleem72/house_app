// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'income_bloc.dart';

class IncomeState extends Equatable {
  final List<Entry> entries;
  const IncomeState({required this.entries});

  @override
  List<Object> get props => [
        entries,
      ];

  factory IncomeState.initial() => const IncomeState(
        entries: [],
      );

  IncomeState copyWith({
    List<Entry>? entries,
  }) {
    return IncomeState(
      entries: entries ?? this.entries,
    );
  }
}
