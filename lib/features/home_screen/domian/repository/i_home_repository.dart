//

import '../models/button_category.dart';

abstract class IHomeRepository {
  Future<List<ExpenseCategoryWithPercent>> fetchData();
  Stream<List<ExpenseCategoryWithPercent>> subcribe();
  Future dispose();
}
