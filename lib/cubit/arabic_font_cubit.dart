import 'package:bloc/bloc.dart';
import 'package:learnquran/dto/font_family.dart';

class ArabicFontCubit extends Cubit<FontFamilyOptions> {
  ArabicFontCubit() : super(FontFamilyOptions.alqalam);

  select(FontFamilyOptions fontFamilyOption) {
    emit(fontFamilyOption);
  }
}
