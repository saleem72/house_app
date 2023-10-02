//

// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:house_app/configuration/theme/colors.dart';

class _AppThemeColors {
  _AppThemeColors._();

  static const Color primary10 = Color(0xFF9a5918);
  static const Color primary20 = Color(0xFFc7731f);
  static const Color primary30 = Color(0xFFe08c38);
  static const Color primary40 = Color(0xFFE7A867);
  static const Color primary80 = Color(0xFFC5A284);
  static const Color primary90 = Color(0xFFD0B39B);
  static const Color primary100 = Color(0xFFFFFFFF);

  static const Color secondary10 = Color(0xFFb0661c);
  static const Color secondary20 = Color(0xFFdd8022);
  static const Color secondary30 = Color(0xFFe3994f);
  static const Color secondary40 = Color(0xFFeab37b);
  static const Color secondary80 = Color(0xFFf1cca7);
  static const Color secondary90 = Color(0xFFf8e6d3);
  static const Color secondary100 = Color(0xFFFFFFFF);

  static const Color tertiary10 = Color(0xFF2f041c);
  static const Color tertiary20 = Color(0xFF5d0937);
  static const Color tertiary30 = Color(0xFF8c0d53);
  static const Color tertiary40 = Color(0xFFb6116b);
  static const Color tertiary80 = Color(0xFFf6a2d0);
  static const Color tertiary90 = Color(0xFFfbd0e8);
  static const Color tertiary100 = Color(0xFFFFFFFF);

  static const Color error10 = Color(0xFF330000);
  static const Color error20 = Color(0xFF650101);
  static const Color error30 = Color(0xFF980101);
  static const Color error40 = Color(0xFFc30101);
  static const Color error80 = Color(0xFFfe9a9a);
  static const Color error90 = Color(0xFFffcccc);
  static const Color error100 = Color(0xFFFFFFFF);

  static const Color neutral10 = Color(0xFF181b18);
  static const Color neutral20 = Color(0xFF2f372f);
  static const Color neutral90 = Color(0xFFe4e7e4);
  static const Color neutral95 = Color(0xFFf7f8f7);
  static const Color neutral99 = Color(0xFFffffff);

  static const Color neutralVariant30 = Color(0xFF485148);
  static const Color neutralVariant50 = Color(0xFF788778);
  static const Color neutralVariant60 = Color(0xFF939f93);
  static const Color neutralVariant80 = Color(0xFFc9cfc9);
  static const Color neutralVariant90 = Color(0xFFE4E7E4);
}

const darkColorPalette = ColorScheme(
    brightness: Brightness.dark,
    primary: _AppThemeColors.primary80,
    onPrimary: _AppThemeColors.primary20,
    primaryContainer: _AppThemeColors.primary30,
    onPrimaryContainer: _AppThemeColors.primary90,
    inversePrimary: _AppThemeColors.primary40,
    secondary: _AppThemeColors.secondary80,
    onSecondary: _AppThemeColors.secondary20,
    secondaryContainer: _AppThemeColors.secondary30,
    onSecondaryContainer: _AppThemeColors.secondary90,
    tertiary: _AppThemeColors.tertiary80,
    onTertiary: _AppThemeColors.tertiary20,
    tertiaryContainer: _AppThemeColors.tertiary30,
    onTertiaryContainer: _AppThemeColors.tertiary90,
    error: _AppThemeColors.error80,
    onError: _AppThemeColors.error20,
    errorContainer: _AppThemeColors.error30,
    onErrorContainer: _AppThemeColors.error90,
    background: _AppThemeColors.neutral10,
    onBackground: _AppThemeColors.neutral90,
    surface: _AppThemeColors.neutralVariant30,
    onSurface: _AppThemeColors.neutralVariant80,
    inverseSurface: _AppThemeColors.neutral90,
    onInverseSurface: _AppThemeColors.neutral10,
    surfaceVariant: _AppThemeColors.neutralVariant30,
    onSurfaceVariant: _AppThemeColors.neutralVariant80,
    outline: _AppThemeColors.neutralVariant80);

const lightColorPalette = ColorScheme(
  brightness: Brightness.light,
  primary: _AppThemeColors.primary40,
  onPrimary: Colors.white,
  primaryContainer: _AppThemeColors.primary90,
  onPrimaryContainer: _AppThemeColors.primary10,
  inversePrimary: _AppThemeColors.primary80,
  secondary: _AppThemeColors.secondary40,
  onSecondary: Colors.white,
  secondaryContainer: _AppThemeColors.secondary90,
  onSecondaryContainer: _AppThemeColors.secondary10,
  tertiary: _AppThemeColors.tertiary40,
  onTertiary: Colors.white,
  tertiaryContainer: _AppThemeColors.tertiary90,
  onTertiaryContainer: _AppThemeColors.tertiary10,
  error: _AppThemeColors.error40,
  onError: Colors.white,
  errorContainer: _AppThemeColors.error90,
  onErrorContainer: _AppThemeColors.error10,
  background: _AppThemeColors.neutral99,
  onBackground: _AppThemeColors.neutral10,
  surface: _AppThemeColors.neutralVariant90,
  onSurface: _AppThemeColors.neutralVariant30,
  inverseSurface: _AppThemeColors.neutral20,
  onInverseSurface: _AppThemeColors.neutral95,
  surfaceVariant: _AppThemeColors.neutralVariant90,
  onSurfaceVariant: _AppThemeColors.neutralVariant30,
  outline: _AppThemeColors.neutralVariant50,
);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: lightColorPalette,
  scaffoldBackgroundColor: _AppThemeColors.neutral95,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: AppColors.primary,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: _AppThemeColors.primary40,
    foregroundColor: Colors.white,
  ),
  fontFamily: 'Dubai',
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: darkColorPalette,
  scaffoldBackgroundColor: _AppThemeColors.neutral10,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 20,
      color: AppColors.primary,
      fontWeight: FontWeight.bold,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: _AppThemeColors.primary80,
    foregroundColor: _AppThemeColors.primary20,
  ),
  fontFamily: 'Dubai',
);

Future<void> hideSystemNavigationBar() async {
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersive,
    // overlays: [SystemUiOverlay.top],
  );
}

Future<void> onlyPortrait() async {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

void setStatusBarAndNavigationBarColor(ThemeMode themeMode) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness:
        themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
    // systemNavigationBarIconBrightness:
    //     themeMode == ThemeMode.light ? Brightness.light : Brightness.dark,
    // systemNavigationBarColor: themeMode == ThemeMode.light
    //     ? _AppThemeColors.neutralVariant30
    //     : _AppThemeColors.neutralVariant90,
    // systemNavigationBarDividerColor: Colors.transparent,
  ));
}
