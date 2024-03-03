import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


class AudioButton extends StatelessWidget {
  const AudioButton({
    super.key,
    required this.wordId,
  });

  final int wordId;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Icon(Icons.volume_up),
      onPressed: () async {
        final player = AudioPlayer();
        final String filePath = 'audio/words/$wordId.mp3';
        await player.play(AssetSource(filePath));
      },
    );
  }
}
