//

import 'package:get_it/get_it.dart';
import 'package:house_app/core/data/local_db/app_database.dart';
import 'package:house_app/core/domain/helpers/safe/safe.dart';
import 'package:house_app/core/presentation/blocs/add_entry_bloc/add_entry_bloc.dart';
import 'package:house_app/core/presentation/blocs/locale_bloc/locale_bloc.dart';
import 'package:house_app/features/daily_screen/daily_dependencies.dart';
import 'package:house_app/features/history/history_dependencies.dart';
import 'package:house_app/features/income/income_dependencies.dart';
import 'package:house_app/features/monthly_screen/monthly_dependencies.dart';
import 'package:house_app/features/weekly_screen/weekly_dependencies.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future initDependencies() async {
  locator.registerLazySingleton(() => AppDatabase());

  initDailyDependencies();

  initWeeklyDependencies();

  initMonthlyDependencies();

  initIncomeDependencies();

  initHistoryDependencies();

  locator
      .registerFactory(() => AddEntryBloc(db: locator(), date: DateTime.now()));

  //

  // Externals
  final storage = await SharedPreferences.getInstance();

  locator.registerSingleton<SharedPreferences>(storage);
  locator.registerSingleton(Safe(storage: storage));

  locator.registerSingleton(LocaleBloc(safe: locator()));
}
