//

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechApi {
  static final _speech = SpeechToText();

  static Future<bool> toggleRecording({
    required Function(String text) onResult,
    required ValueChanged<bool> onListening,
    required ValueChanged<SpeechRecognitionError> onError,
  }) async {
    if (_speech.isListening) {
      _speech.stop();
      return true;
    }

    final isAvailable = await _speech.initialize(
      onStatus: (status) => onListening(_speech.isListening),
      onError: (e) => onError(e),
    );

    if (isAvailable) {
      _speech.listen(
          localeId: 'ar_AE',
          onResult: (value) => onResult(value.recognizedWords));
      // var locales = await _speech.locales();
      // for (var local in locales) {
      //   print("${local.localeId}: ${local.name}");
      // }
    }

    return isAvailable;
  }
}
