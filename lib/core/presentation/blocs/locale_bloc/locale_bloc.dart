//

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/domain/helpers/safe/safe.dart';

part 'locale_event.dart';
part 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  final Safe _safe;
  LocaleBloc({
    required Safe safe,
  })  : _safe = safe,
        super(LocaleState.initial(safe: safe)) {
    on<LocaleSetLocaleEvent>(_onSetLocale);
    on<LocaleSetSpeechLocaleEvent>(_onSetSpeechLocale);
    on<LocaleArabicCurrencyChangedEvent>(_onArabicCurrencyChanged);
    on<LocaleEnglishCurrencyChangedEvent>(_onEnglishCurrencyChanged);
  }

  _onSetLocale(LocaleSetLocaleEvent event, Emitter<LocaleState> emit) async {
    final _ = await _safe.setLocal(event.locale.languageCode);
    emit(state.copyWith(appLang: event.locale));
  }

  _onSetSpeechLocale(
      LocaleSetSpeechLocaleEvent event, Emitter<LocaleState> emit) async {
    final _ = await _safe.setSpeechLocal(event.locale.languageCode);
    emit(state.copyWith(speechLang: event.locale));
  }

  _onArabicCurrencyChanged(
      LocaleArabicCurrencyChangedEvent event, Emitter<LocaleState> emit) async {
    final _ = await _safe.setArabicCurrency(event.value);
    emit(state.copyWith(currencyAR: event.value));
  }

  _onEnglishCurrencyChanged(LocaleEnglishCurrencyChangedEvent event,
      Emitter<LocaleState> emit) async {
    final _ = await _safe.setEnglishCurrency(event.value);
    emit(state.copyWith(currencyEN: event.value));
  }
}
