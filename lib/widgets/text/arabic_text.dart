import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnquran/cubit/arabic_font_cubit.dart';
import 'package:learnquran/dto/font_family.dart';

class ArabicText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final double? fontSize;
  const ArabicText(this.text, {super.key, this.textAlign, this.fontSize = 32});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArabicFontCubit, FontFamilyOptions>(
      builder: (context, selectedFontFamilyOption) {
        return Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
              fontSize: fontSize,
              fontFamily: fontMap[selectedFontFamilyOption]),
        );
      },
    );
  }
}
