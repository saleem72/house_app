//

import 'package:house_app/features/history/domain/models/history_data_model.dart';

abstract class IHistoryRepository {
  Future<HistoryDataModel> fetchData(DateTime date);
}
