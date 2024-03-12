//

import 'package:get_it/get_it.dart';
import 'package:house_app/features/weekly_screen/data/repository/weekly_repository.dart';
import 'package:house_app/features/weekly_screen/domain/repository/i_weekly_repository.dart';

initWeeklyDependencies() {
  final locator = GetIt.instance;

  locator.registerLazySingleton<IWeeklyRepository>(
      () => WeeklyRepository(db: locator()));
}
