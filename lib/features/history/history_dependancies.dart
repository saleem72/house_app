//

import 'package:get_it/get_it.dart';
import 'package:house_app/features/history/data/repository/history_repository.dart';
import 'package:house_app/features/history/domain/repository/i_history_repository.dart';
import 'package:house_app/features/history/presentation/history_bloc/history_bloc.dart';

initHistoryDependancies() {
  final locator = GetIt.instance;

  locator.registerLazySingleton<IHistoryRepository>(
    () => HistoryRepository(
      db: locator(),
    ),
  );

  locator.registerFactory(
    () => HistoryBloc(
      repository: locator(),
    ),
  );
}
