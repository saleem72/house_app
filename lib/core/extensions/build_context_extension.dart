//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../presentation/blocs/locale_bloc/locale_bloc.dart';

extension ContextProperties on BuildContext {
  AppLocalizations get translate => AppLocalizations.of(this)!;
  NavigatorState get navigator => Navigator.of(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  TextDirection get currentDirection => Directionality.of(this);

  String get currency {
    final locale = read<LocaleBloc>().state;
    final currency = currentDirection == TextDirection.ltr
        ? locale.currencyEN
        : locale.currencyAR;
    return currency;
  }

  bool get isArabic {
    final locale = read<LocaleBloc>().state;
    return locale.appLang.languageCode == 'en' ? false : true;
  }
}
