//

import 'package:get_it/get_it.dart';
import 'package:house_app/features/income/data/repository/income_repository.dart';
import 'package:house_app/features/income/domain/repository/i_income_repository.dart';
import 'package:house_app/features/income/presentation/income_bloc/income_bloc.dart';

initIncomeDependancies() {
  final locator = GetIt.instance;
  locator.registerFactory<IIncomeRepository>(
      () => IncomeRepository(db: locator(), mapper: locator()));
  locator.registerFactory(() => IncomeBloc(repository: locator()));
}
