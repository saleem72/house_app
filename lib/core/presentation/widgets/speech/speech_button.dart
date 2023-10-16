//

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:house_app/core/extensions/build_context_extension.dart';

import 'speech.dart';

class IconListeningButton extends StatefulWidget {
  const IconListeningButton({super.key, required this.hasText});
  final Function(String text) hasText;
  @override
  State<IconListeningButton> createState() => _IconListeningButtonState();
}

class _IconListeningButtonState extends State<IconListeningButton> {
  bool isListening = false;
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      alignment: Alignment.center,
      child: AvatarGlow(
        animate: isListening,
        endRadius: 75,
        glowColor: Theme.of(context).colorScheme.primary,
        child: SizedBox(
          width: 48,
          height: 48,
          child: Center(
            child: TextButton(
              onPressed: toggleRecording,
              style: TextButton.styleFrom(
                shape: const CircleBorder(),
                // padding: EdgeInsets.all(20),
                backgroundColor:
                    Theme.of(context).colorScheme.secondary, // <-- Button color
                foregroundColor: Theme.of(context)
                    .colorScheme
                    .onSecondary, // <-- Splash color
              ),
              child: Center(
                child: Icon(isListening ? Icons.mic : Icons.mic_none, size: 24),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future toggleRecording() => SpeechApi.toggleRecording(
        onResult: (text) {
          setState(() => this.text = text);
          widget.hasText(text);
        },
        onListening: (isListening) {
          setState(() => this.isListening = isListening);

          if (!isListening) {
            Future.delayed(const Duration(seconds: 1), () {
              // ignore: avoid_print
              print(text);
            });
          }
        },
        onError: (error) => _showError(context, error.errorMsg),
      );

  _showError(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(context.translate.speech_error),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.translate.speech_error_message,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                errorMessage,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.navigator.pop();
              },
              child: Text(
                'Ok',
                style: context.textTheme.titleMedium?.copyWith(
                    // color: Colors.grey,
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}
