import 'package:flutter/material.dart';
import 'package:learnquran/theme/theme_extension_colors.dart';

ThemeExtensionColors colors(context) =>
    Theme.of(context).extension<ThemeExtensionColors>()!;

ThemeData getLightTheme() {
  return ThemeData(
    primaryColor: const Color(0xffF9EDD4),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF7C5800),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFFFDEA8),
      onPrimaryContainer: Color(0xFF271900),
      secondary: Color(0xFF006879),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFABEDFF),
      onSecondaryContainer: Color(0xFF001F26),
      tertiary: Color(0xFF006D39),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFF9AF6B3),
      onTertiaryContainer: Color(0xFF00210D),
      error: Color(0xFFBA1A1A),
      errorContainer: Color(0xFFFFDAD6),
      onError: Color(0xFFFFFFFF),
      onErrorContainer: Color(0xFF410002),
      background: Color(0xFFFFFBFF),
      onBackground: Color(0xFF231A00),
      surface: Color(0xFFFFFBFF),
      onSurface: Color(0xFF231A00),
      surfaceVariant: Color(0xFFEEE1CF),
      onSurfaceVariant: Color(0xFF4E4639),
      outline: Color(0xFF807667),
      onInverseSurface: Color(0xFFFFF0CB),
      inverseSurface: Color(0xFF3C2F00),
      inversePrimary: Color(0xFFF8BD49),
      shadow: Color(0xFF000000),
      surfaceTint: Color(0xFF7C5800),
      outlineVariant: Color(0xFFD1C5B4),
      scrim: Color(0xFF000000),
    ),
    extensions: <ThemeExtension<ThemeExtensionColors>>[
      ThemeExtensionColors(
        defaultWordBackground: Colors.amber.shade100,
        maleWordBackground: Colors.blue.shade50,
        femaleWordBackground: Colors.pink.shade50,
        defaultWordIcon: Colors.amber.shade900,
        maleWordIcon: Colors.blue.shade400,
        femaleWordIcon: Colors.pink.shade400,
      )
    ],
  );
}

ThemeData getDarkTheme() {
  return ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFF8BD49),
      onPrimary: Color(0xFF422D00),
      primaryContainer: Color(0xFF5E4200),
      onPrimaryContainer: Color(0xFFFFDEA8),
      secondary: Color(0xFF55D6F3),
      onSecondary: Color(0xFF003640),
      secondaryContainer: Color(0xFF004E5C),
      onSecondaryContainer: Color(0xFFABEDFF),
      tertiary: Color(0xFF7FDA99),
      onTertiary: Color(0xFF00391B),
      tertiaryContainer: Color(0xFF005229),
      onTertiaryContainer: Color(0xFF9AF6B3),
      error: Color(0xFFFFB4AB),
      errorContainer: Color(0xFF93000A),
      onError: Color(0xFF690005),
      onErrorContainer: Color(0xFFFFDAD6),
      background: Color(0xFF231A00),
      onBackground: Color(0xFFFFE086),
      surface: Color(0xFF231A00),
      onSurface: Color(0xFFFFE086),
      surfaceVariant: Color(0xFF4E4639),
      onSurfaceVariant: Color(0xFFD1C5B4),
      outline: Color(0xFF9A8F80),
      onInverseSurface: Color(0xFF231A00),
      inverseSurface: Color(0xFFFFE086),
      inversePrimary: Color(0xFF7C5800),
      shadow: Color(0xFF000000),
      surfaceTint: Color(0xFFF8BD49),
      outlineVariant: Color(0xFF4E4639),
      scrim: Color(0xFF000000),
    ),
    extensions: <ThemeExtension<ThemeExtensionColors>>[
      ThemeExtensionColors(
        defaultWordBackground: Colors.amber.shade900,
        maleWordBackground: Colors.blue.shade700,
        femaleWordBackground: Colors.pink.shade900,
        defaultWordIcon: Colors.amber.shade700,
        maleWordIcon: Colors.blue.shade200,
        femaleWordIcon: Colors.pink.shade200,
      )
    ],
  );
}
