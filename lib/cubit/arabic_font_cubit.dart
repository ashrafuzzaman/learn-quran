import 'package:bloc/bloc.dart';
import 'package:learnquran/dto/font_family.dart';
import 'package:learnquran/repository/settings_repo.dart';

class ArabicFontCubit extends Cubit<FontFamilyOptions> {
  ArabicFontCubit() : super(FontFamilyOptions.alqalam) {
    initialize();
  }

  initialize() {
    var repo = SettingsRepo();
    repo.getFontFamily().then((FontFamilyOptions fontFamily) {
      emit(fontFamily);
    });
  }

  select(FontFamilyOptions fontFamilyOption) {
    var repo = SettingsRepo();
    repo.setFontFamily(fontFamilyOption).then((_) => emit(fontFamilyOption));
  }
}
