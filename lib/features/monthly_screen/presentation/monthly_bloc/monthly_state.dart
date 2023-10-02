part of 'monthly_bloc.dart';

sealed class MonthlyState extends Equatable {
  const MonthlyState();

  @override
  List<Object> get props => [];
}

final class MonthlyInitial extends MonthlyState {}

final class MonthlyLoading extends MonthlyState {}

final class MonthlySuccess extends MonthlyState {
  final List<WeekExpnces> weeks;

  const MonthlySuccess({required this.weeks});

  @override
  List<Object> get props => [weeks];
}
