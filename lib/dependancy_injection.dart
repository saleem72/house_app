//

import 'package:get_it/get_it.dart';
import 'package:house_app/core/data/local_db/app_database.dart';
import 'package:house_app/core/domian/helpers/safe/safe.dart';
import 'package:house_app/core/presentation/blocs/add_entry_bloc/add_entry_bloc.dart';
import 'package:house_app/core/presentation/blocs/locale_bloc/locale_bloc.dart';
import 'package:house_app/features/daily_screen/daily_dependancies.dart';
import 'package:house_app/features/monthly_screen/monthly_dependancies.dart';
import 'package:house_app/features/weekly_screen/weekly_dependancies.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future initDependencies() async {
  locator.registerLazySingleton(() => AppDatabase());

  initDailyDependancies();

  initWeeklyDependancies();

  initMonthlyDependancies();

  locator
      .registerFactory(() => AddEntryBloc(db: locator(), date: DateTime.now()));

  //

  // Externals
  final storage = await SharedPreferences.getInstance();

  locator.registerSingleton<SharedPreferences>(storage);
  locator.registerSingleton(Safe(storage: storage));

  locator.registerSingleton(LocaleBloc(safe: locator()));
}
