//

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String text = newValue.text.replaceAll(',', '');

    double? value = double.tryParse(text);

    if (value == null) {
      return oldValue;
    }

    final lastChar = newValue.text.substring(newValue.text.length - 1);
    final hasPeriod = lastChar == '.';

    final formatter = NumberFormat('#,##0.##');

    String newText = formatter.format(value);
    if (hasPeriod) {
      newText = '$newText.';
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
