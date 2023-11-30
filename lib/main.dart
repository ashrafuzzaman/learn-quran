import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnquran/pages/home.dart';

void main() {
  // final file = File('assets/words-en.yaml');
  // final yamlString = file.readAsStringSync();
  // final doc = loadYaml(yamlString);

  // print(doc['words']);
  // rootBundle.loadString('assets/data/words-en.yaml').then((yamlString) {
  //   Map<String, dynamic> words = loadYaml(yamlString);
  //   print('===============================================');
  //   print(words);
  //   print('===============================================');
  // });

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Learn Quran",
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('bn'), // English
      ],
      home: HomePage(),
    );
  }
}
