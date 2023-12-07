import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnquran/cubit/arabic_font_cubit.dart';
import 'package:learnquran/dto/font_family.dart';

class QuickFontSelector extends StatelessWidget {
  const QuickFontSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArabicFontCubit, FontFamilyOptions>(
      builder: (context, selectedFontFamilyOption) {
        return PopupMenuButton<FontFamilyOptions>(
          icon: const Icon(Icons.font_download),
          initialValue: selectedFontFamilyOption,
          onSelected: (FontFamilyOptions fontFamily) {
            context.read<ArabicFontCubit>().select(fontFamily);
          },
          itemBuilder: (BuildContext context) => fontMap.keys
              .map((fontFamilyKey) => PopupMenuItem<FontFamilyOptions>(
                    value: fontFamilyKey,
                    child: Text(fontMap[fontFamilyKey]!),
                  ))
              .toList(),
        );
      },
    );
  }
}
