part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {
  final expenses = const <ExpenseCategoryWithPercent>[
    ExpenseCategoryWithPercent(
        category: ButtonCategory.month, amount: 10000, percent: 1),
    ExpenseCategoryWithPercent(
        category: ButtonCategory.week, amount: 4000, percent: 1),
    ExpenseCategoryWithPercent(
        category: ButtonCategory.day, amount: 1200, percent: 1),
  ];
}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<ExpenseCategoryWithPercent> expenses;

  const HomeSuccess({required this.expenses});

  @override
  List<Object> get props => [expenses];
}
