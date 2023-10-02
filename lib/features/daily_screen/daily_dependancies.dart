//

import 'package:get_it/get_it.dart';
import 'package:house_app/core/data/mappers/entry_mapper.dart';
import 'package:house_app/features/daily_screen/data/daily_repository.dart';
import 'package:house_app/features/daily_screen/domain/repository/i_daily_repository.dart';
import 'package:house_app/features/daily_screen/presentation/bloc/daily_bloc.dart';
import 'package:house_app/features/daily_summary_screen/data/repository/daily_summary_repository.dart';
import 'package:house_app/features/daily_summary_screen/domain/repository/i_daily_summary_repository.dart';

initDailyDependancies() {
  final locator = GetIt.instance;
  locator.registerLazySingleton(() => EntryMapper());
  locator.registerFactory<IDailyRepository>(
      () => DailyRepository(db: locator(), mapper: locator()));
  locator.registerLazySingleton<IDailySummaryRepository>(
      () => DialySummaryRepository(db: locator(), mapper: locator()));
  locator.registerFactory(() => DailyBloc(repository: locator()));
}
