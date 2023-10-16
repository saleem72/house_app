//

import 'package:flutter/material.dart';

extension IntegerDivision on int {
  int div(int by) {
    if (by == 0) {
      return 0;
    } else {
      return this ~/ by;
    }
  }

  Color get percentColor {
    if (this >= 0 && this <= 60) {
      return Colors.green.shade300;
    } else if (this > 60 && this < 90) {
      return Colors.orange.shade300;
    } else {
      return Colors.red.shade400;
    }
  }
}
