import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:learnquran/cubit/arabic_font_cubit.dart';
import 'package:learnquran/cubit/lessons_cubit.dart';
import 'package:learnquran/screens/home.dart';
import 'package:learnquran/service/database.dart';
import 'package:learnquran/theme/app_theme.dart';
import 'package:logging/logging.dart';

void main() async {
  Logger.root.level = Level.ALL;
  // TODO: move this to a loading screen, as this might take time.
  WidgetsFlutterBinding.ensureInitialized();
  await DbService().initiate();

  // final log = Logger('main');
  // Logger.root.onRecord.listen((record) {
  //   print('${record.level.name}: ${record.message}');
  // });

  // var result = await QuizAttemptRepo().getWordAttemptsWithCount();
  // log.info(result);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LessonsCubit(),
        ),
        BlocProvider(
          create: (context) => ArabicFontCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Learn Quran",
        theme: getLightFlexTheme(FlexScheme.bahamaBlue),
        // darkTheme: getDarkFlexTheme(FlexScheme.bahamaBlue),
        // themeMode: ThemeMode.system,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('bn'), // English
        ],
        home: const HomePage(),
      ),
    );
  }
}
