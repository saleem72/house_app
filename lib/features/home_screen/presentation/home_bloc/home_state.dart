part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {
  final expenses = const <ExpenseCategory>[
    ExpenseCategory(category: ButtonCategory.month, amount: 10000),
    ExpenseCategory(category: ButtonCategory.week, amount: 4000),
    ExpenseCategory(category: ButtonCategory.day, amount: 1200),
  ];
}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<ExpenseCategory> expenses;

  const HomeSuccess({required this.expenses});

  @override
  List<Object> get props => [expenses];
}
