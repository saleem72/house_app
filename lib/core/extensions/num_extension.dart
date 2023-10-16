//

import 'dart:math' as math;

extension DoubleAngles on num {
  double toRadian() {
    return this * (math.pi / 180);
  }
}
