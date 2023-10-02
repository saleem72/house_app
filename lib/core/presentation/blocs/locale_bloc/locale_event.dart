part of 'locale_bloc.dart';

sealed class LocaleEvent extends Equatable {
  const LocaleEvent();

  @override
  List<Object> get props => [];
}

final class LocaleSetLocaleEvent extends LocaleEvent {
  final Locale locale;

  const LocaleSetLocaleEvent({required this.locale});

  @override
  List<Object> get props => [locale];
}

final class LocaleSetSpeechLocaleEvent extends LocaleEvent {
  final Locale locale;

  const LocaleSetSpeechLocaleEvent({required this.locale});

  @override
  List<Object> get props => [locale];
}

final class LocaleArabicCurrencyChangedEvent extends LocaleEvent {
  final String value;

  const LocaleArabicCurrencyChangedEvent({required this.value});

  @override
  List<Object> get props => [value];
}

final class LocaleEnglishCurrencyChangedEvent extends LocaleEvent {
  final String value;

  const LocaleEnglishCurrencyChangedEvent({required this.value});

  @override
  List<Object> get props => [value];
}
