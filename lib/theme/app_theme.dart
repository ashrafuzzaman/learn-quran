import 'package:flutter/material.dart';
import 'package:learnquran/theme/theme_extension_colors.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

ThemeExtensionColors colors(context) =>
    Theme.of(context).extension<ThemeExtensionColors>()!;

ThemeData getLightTheme() {
  const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF694FA3),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFEADDFF),
    onPrimaryContainer: Color(0xFF24005B),
    secondary: Color(0xFF95416D),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFFFD8E7),
    onSecondaryContainer: Color(0xFF3D0026),
    tertiary: Color(0xFF744B9E),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFEFDBFF),
    onTertiaryContainer: Color(0xFF2B0052),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFFFBFF),
    onBackground: Color(0xFF341100),
    surface: Color(0xFFFFFBFF),
    onSurface: Color(0xFF341100),
    surfaceVariant: Color(0xFFE7E0EB),
    onSurfaceVariant: Color(0xFF49454E),
    outline: Color(0xFF7A757F),
    onInverseSurface: Color(0xFFFFEDE6),
    inverseSurface: Color(0xFF552000),
    inversePrimary: Color(0xFFD1BCFF),
    shadow: Color(0xFF1E1E1E),
    surfaceTint: Color(0xFF694FA3),
    outlineVariant: Color(0xFFCAC4CF),
    scrim: Color(0xFF000000),
  );

  return ThemeData(
    primaryColor: const Color(0xffF9EDD4),
    colorScheme: lightColorScheme,
    extensions: <ThemeExtension<ThemeExtensionColors>>[
      ThemeExtensionColors(
        success: const Color(0xFF9ADE7B),
        defaultWordBackground: Colors.amber[50],
        maleWordBackground: Colors.blue.shade50,
        femaleWordBackground: Colors.pink.shade50,
        defaultWordIcon: Colors.amber.shade700,
        maleWordIcon: Colors.blue.shade300,
        femaleWordIcon: Colors.pink.shade300,
      )
    ],
  );
}

ThemeData getLightFlexTheme(FlexScheme scheme) {
  return FlexThemeData.light(
      scheme: scheme,
      appBarElevation: 2,
      extensions: <ThemeExtension<ThemeExtensionColors>>[
        ThemeExtensionColors(
          success: const Color(0xFF9ADE7B),
          defaultWordBackground: Colors.amber[50],
          maleWordBackground: Colors.blue.shade50,
          femaleWordBackground: Colors.pink.shade50,
          defaultWordIcon: Colors.amber.shade700,
          maleWordIcon: Colors.blue.shade300,
          femaleWordIcon: Colors.pink.shade300,
        )
      ]);
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
        success: const Color(0xFF006D39),
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

ThemeData getDarkFlexTheme(FlexScheme scheme) {
  return FlexThemeData.dark(
      scheme: scheme,
      extensions: <ThemeExtension<ThemeExtensionColors>>[
        ThemeExtensionColors(
          success: const Color(0xFF006D39),
          defaultWordBackground: Colors.amber.shade900,
          maleWordBackground: Colors.blue.shade700,
          femaleWordBackground: Colors.pink.shade900,
          defaultWordIcon: Colors.amber.shade700,
          maleWordIcon: Colors.blue.shade200,
          femaleWordIcon: Colors.pink.shade200,
        )
      ]);
}
