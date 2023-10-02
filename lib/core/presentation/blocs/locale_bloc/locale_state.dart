// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'locale_bloc.dart';

class LocaleState extends Equatable {
  final Locale appLang;
  final Locale speechLang;
  final String currencyAR;
  final String currencyEN;
  const LocaleState({
    required this.appLang,
    required this.speechLang,
    required this.currencyAR,
    required this.currencyEN,
  });

  @override
  List<Object> get props => [
        appLang,
        speechLang,
        currencyAR,
        currencyEN,
      ];

  factory LocaleState.initial({required Safe safe}) => LocaleState(
        appLang: safe.getLocal(),
        speechLang: safe.getSpeechLocal(),
        currencyAR: safe.getArabicCurrency(),
        currencyEN: safe.getEnglishCurrency(),
      );

  LocaleState copyWith({
    Locale? appLang,
    Locale? speechLang,
    String? currencyAR,
    String? currencyEN,
  }) {
    return LocaleState(
      appLang: appLang ?? this.appLang,
      speechLang: speechLang ?? this.speechLang,
      currencyAR: currencyAR ?? this.currencyAR,
      currencyEN: currencyEN ?? this.currencyEN,
    );
  }
}
