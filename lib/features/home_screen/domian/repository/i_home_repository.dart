//

import '../models/button_category.dart';

abstract class IHomeRepository {
  Future<List<ExpenseCategory>> fetchData();
  Stream<List<ExpenseCategory>> subcribe();
  Future dispose();
}
