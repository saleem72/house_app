// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SafeKeys {
  SafeKeys._();

  static const String languageCode = 'languageCode';
  static const String speechLanguageCode = "speechLanguageCode";
  static const String arabicCurrency = "arabicCurrency";
  static const String englishCurrency = "englishCurrency";
  static const String englishCode = 'en';
  static const String arabicCode = 'ar_SY';
  static const String english = "English";
  static const String arabic = "Arabic";

  static const String themeKey = 'themeKey';
  static const String isFirstRun = 'is_first_run';
}

class Safe {
  final SharedPreferences _storage;
  Safe({
    required SharedPreferences storage,
  }) : _storage = storage;

  // Localization
  Future<Locale> setLocal(String languageCode) async {
    await _storage.setString(SafeKeys.languageCode, languageCode);
    return _locale(languageCode);
  }

  Future<Locale> setSpeechLocal(String languageCode) async {
    await _storage.setString(SafeKeys.speechLanguageCode, languageCode);
    return _locale(languageCode);
  }

  Future<String> setArabicCurrency(String currency) async {
    await _storage.setString(SafeKeys.arabicCurrency, currency);
    return currency;
  }

  Future<String> setEnglishCurrency(String currency) async {
    await _storage.setString(SafeKeys.englishCurrency, currency);
    return currency;
  }

  Locale getLocal() {
    final languageCode =
        _storage.getString(SafeKeys.languageCode) ?? SafeKeys.englishCode;
    return _locale(languageCode);
  }

  Locale getSpeechLocal() {
    final languageCode =
        _storage.getString(SafeKeys.speechLanguageCode) ?? SafeKeys.englishCode;
    return _locale(languageCode);
  }

  String getArabicCurrency() {
    final currency = _storage.getString(SafeKeys.arabicCurrency) ?? '';
    return currency;
  }

  String getEnglishCurrency() {
    final currency = _storage.getString(SafeKeys.englishCurrency) ?? '';
    return currency;
  }

  Locale _locale(String languageCode) {
    switch (languageCode) {
      case SafeKeys.englishCode:
        return const Locale(SafeKeys.englishCode, '');
      case SafeKeys.arabicCode:
        return const Locale(SafeKeys.arabicCode, '');
      default:
        return const Locale(SafeKeys.englishCode, '');
    }
  }

  // Themeing
  Future<String> setThemeMode(String mode) async {
    await _storage.setString(SafeKeys.themeKey, mode);
    return mode;
  }

  ThemeMode getThemeMode() {
    final string = _storage.getString(SafeKeys.themeKey);
    if (string == null) {
      return ThemeMode.system;
    }
    if (string == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  bool get isFirstRun => _storage.getBool(SafeKeys.isFirstRun) ?? true;
  Future updateFirstRun() async {
    await _storage.setBool(SafeKeys.isFirstRun, false);
  }
}
