import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:learnquran/dto/word.dart';

class WordFlipCard extends StatelessWidget {
  final Word word;

  const WordFlipCard(
    this.word, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FlipCard(
      fill: Fill.fillBack, // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.HORIZONTAL, // default
      side: CardSide.FRONT, // The side to initially display.
      front: FlipCardPage(text: word.arabic),
      back: FlipCardPage(text: word.meaning),
    ));
  }
}

class FlipCardPage extends StatelessWidget {
  const FlipCardPage({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
          child: SizedBox(
        height: 200,
        width: double.infinity,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 48),
          ),
        ),
      )),
    );
  }
}
