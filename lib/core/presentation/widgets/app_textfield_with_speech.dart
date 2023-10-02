//

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:house_app/core/extensions/build_context_extension.dart';

import 'speech/speech_button.dart';

class AppTextFieldWithSpeech extends StatelessWidget {
  const AppTextFieldWithSpeech({
    super.key,
    required this.label,
    this.hint = '',
    required this.controller,
    this.onChanged,
    this.inputFormatters,
    this.keyboardType,
    required this.onSpeechRecognition,
  });
  final String label;
  final String hint;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Function(String) onSpeechRecognition;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            IconListeningButton(hasText: (text) {
              onSpeechRecognition(text);
              controller.text = text;
            })
          ],
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
              width: 1,
              color: Colors.grey.shade400,
            )),
          ),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration.collapsed(
              hintText: hint,
              hintStyle: context.textTheme.titleMedium?.copyWith(
                color: Colors.grey.shade400,
              ),
            ),
          ),
        )
      ],
    );
  }
}
