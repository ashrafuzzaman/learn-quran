import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:learnquran/cubit/lessons_cubit.dart';
import 'package:learnquran/screens/home.dart';
import 'package:learnquran/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LessonsCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Learn Quran",
        theme: getLightTheme(),
        // darkTheme: getDarkTheme(),
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
