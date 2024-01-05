import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnquran/cubit/arabic_font_cubit.dart';
import 'package:learnquran/dto/font_family.dart';

class ArabicHighlightedText extends StatelessWidget {
  final String pattern;
  final String sentence;
  final TextAlign? textAlign;
  final double? fontSize;

  const ArabicHighlightedText(this.pattern, this.sentence,
      {super.key, this.textAlign, this.fontSize = 32});

  @override
  Widget build(BuildContext context) {
    var words = sentence.split(RegExp(r'\s+'));

    return BlocBuilder<ArabicFontCubit, FontFamilyOptions>(
      builder: (context, selectedFontFamilyOption) {
        return RichText(
          text: TextSpan(
            children: words.map((word) {
              var isEqual = pattern == word;
              return TextSpan(
                text: '$word ',
                style: isEqual
                    ? TextStyle(
                            fontFamily: fontMap[selectedFontFamilyOption],
                            fontSize: fontSize,
                            letterSpacing: 0)
                        .merge(const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red))
                    : TextStyle(
                            fontFamily: fontMap[selectedFontFamilyOption],
                            fontSize: fontSize,
                            letterSpacing: 0)
                        .merge(const TextStyle(color: Colors.black)),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
