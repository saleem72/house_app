//

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

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
              print(text);
            });
          }
        },
      );
}
