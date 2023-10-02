part of 'monthly_bloc.dart';

sealed class MonthlyEvent extends Equatable {
  const MonthlyEvent();

  @override
  List<Object> get props => [];
}

class MonthlyFetchDataEvent extends MonthlyEvent {}
