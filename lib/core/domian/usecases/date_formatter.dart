//

import 'package:flutter/material.dart';
import 'package:house_app/core/extensions/string_extension.dart';
import 'package:intl/intl.dart';

class AppFormatter {
  static final AppFormatter _singleton = AppFormatter._internal();
  final DateFormat _withTimeZone = DateFormat('yyyy-MM-dd HH:mm:ss');
  final NumberFormat _numberFormat = NumberFormat('#,##0');
  final DateFormat _fullDate = DateFormat('EEEE yyyy MMM dd');
  factory AppFormatter() {
    return _singleton;
  }

  AppFormatter._internal();

  String date(DateTime value, {Locale? locale}) {
    DateFormat dateFormat = DateFormat('yyyy MMM dd', locale?.languageCode);
    return dateFormat.format(value);
  }

  String arabicDate(DateTime value, {Locale? locale}) {
    DateFormat dateFormat = DateFormat('yyyy MMM dd', locale?.languageCode);
    final result = dateFormat.format(value);
    return result.arabicMonth();
  }

  String arabicMonth(DateTime value, {Locale? locale}) {
    DateFormat dateFormat = DateFormat('yyyy MMM', locale?.languageCode);
    final result = dateFormat.format(value);
    return result.arabicMonth();
  }

  String fullDate(DateTime value) {
    return _fullDate.format(value);
  }

  String utcFormat(DateTime value) {
    return _withTimeZone.format(value) + value.timeZoneOffset.toString();
  }

  String dayOfDate(DateTime value, {Locale? locale}) {
    DateFormat dayFormat = DateFormat('EEEE', locale?.languageCode);
    return dayFormat.format(value);
  }

  String currency(int value) {
    return _numberFormat.format(value);
  }
}
