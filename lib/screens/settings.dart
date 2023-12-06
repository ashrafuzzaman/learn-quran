import 'package:flutter/material.dart';

/// Flutter code sample for [Radio].

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Radio Sample')),
      body: const Center(
        child: RadioExample(),
      ),
    );
  }
}

enum FontFamilyOptions { alqalam, neirizi }

const Map<FontFamilyOptions, String> fontMap = {
  FontFamilyOptions.alqalam: "Al-Qalam",
  FontFamilyOptions.neirizi: "Neirizi",
};

class RadioExample extends StatefulWidget {
  const RadioExample({super.key});

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  FontFamilyOptions _fontFamily = FontFamilyOptions.alqalam;
  static const arabicTextSample =
      "ذَٰلِكَ ٱلْكِتَـٰبُ لَا رَيْبَ ۛ فِيهِ ۛ هُدًى لِّلْمُتَّقِينَ";

  @override
  Widget build(BuildContext context) {
    var fontOptions = fontMap.keys.map((_fontFamilyKey) => ListTile(
          title: Text(fontMap[_fontFamilyKey]!),
          leading: Radio<FontFamilyOptions>(
            value: _fontFamilyKey,
            groupValue: _fontFamily,
            onChanged: (FontFamilyOptions? fontFamily) {
              setState(() {
                _fontFamily = fontFamily!;
              });
            },
          ),
        ));

    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            arabicTextSample,
            style: TextStyle(fontFamily: fontMap[_fontFamily], fontSize: 24),
          ),
          subtitle: const Text("Sample arabic text"),
        ),
        ...fontOptions,
      ],
    );
  }
}
