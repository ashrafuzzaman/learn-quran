import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnquran/cubit/arabic_font_cubit.dart';
import 'package:learnquran/dto/font_family.dart';
import 'package:learnquran/widgets/text/arabic_text.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(
        child: FontSelector(),
      ),
    );
  }
}

class FontSelector extends StatelessWidget {
  const FontSelector({super.key});

  static const arabicTextSample = "ٱقْرَأْ بِٱسْمِ رَبِّكَ ٱلَّذِى خَلَقَ";

  @override
  Widget build(BuildContext context) {
    var fontOptions = fontMap.keys
        .map((fontFamilyKey) => BlocBuilder<ArabicFontCubit, FontFamilyOptions>(
              builder: (context, selectedFontFamilyOption) {
                return ListTile(
                  title: Text(fontMap[fontFamilyKey]!),
                  leading: Radio<FontFamilyOptions>(
                    value: fontFamilyKey,
                    groupValue: selectedFontFamilyOption,
                    onChanged: (FontFamilyOptions? fontFamily) {
                      context.read<ArabicFontCubit>().select(fontFamily!);
                    },
                  ),
                );
              },
            ));

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          const ListTile(
            title: ArabicText(arabicTextSample),
            subtitle: Text("Sample arabic text"),
          ),
          ...fontOptions,
        ],
      ),
    );
  }
}
