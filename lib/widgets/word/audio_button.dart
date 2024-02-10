import 'package:flutter/material.dart';


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
      onPressed: () {},
    );
  }
}
