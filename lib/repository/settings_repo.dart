import 'package:learnquran/dto/font_family.dart';
import 'package:shared_preferences/shared_preferences.dart';

const fontFamilyPrefKey = 'fontFamily';

class SettingsRepo {
  Future<String?> _getString(key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  _setString(key, value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  Future<FontFamilyOptions> getFontFamily() async {
    final String? fontFamily = await _getString(fontFamilyPrefKey);
    var reversedfontMap = fontMap.map((k, v) => MapEntry(v, k));
    return reversedfontMap[fontFamily] ?? FontFamilyOptions.alqalam;
  }

  Future<void> setFontFamily(FontFamilyOptions fontFamily) async {
    await _setString(fontFamilyPrefKey, fontMap[fontFamily]);
  }
}
