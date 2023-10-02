//

import 'package:get_it/get_it.dart';
import 'package:house_app/features/monthly_screen/data/repository/montly_repository.dart';
import 'package:house_app/features/monthly_screen/presentation/monthly_bloc/monthly_bloc.dart';

import 'domain/repository/i_montly_repository.dart';

initMonthlyDependancies() {
  final locator = GetIt.instance;

  locator.registerLazySingleton<IMonthlyRepository>(
      () => MonthlyRepository(db: locator()));

  locator.registerFactory(() => MonthlyBloc(repository: locator()));
}
