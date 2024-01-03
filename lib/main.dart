import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:learnquran/cubit/arabic_font_cubit.dart';
import 'package:learnquran/screens/home.dart';
import 'package:learnquran/repository/repo_base.dart';
import 'package:learnquran/service/database_initializer.dart';
import 'package:learnquran/theme/app_theme.dart';
import 'package:logging/logging.dart';

void main() async {
  runApp(const MyApp());
}

initializeApp() async {
  Logger.root.level = Level.ALL;
  WidgetsFlutterBinding.ensureInitialized();
  await RepoBase().initiate();
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.message}');
  });
  await initializeWordsDatabaseFromCsv();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Directionality(
              textDirection: TextDirection.ltr,
              child: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }

          return MultiBlocProvider(
            providers: [
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
        });
  }
}
