import 'package:flutter/material.dart';
import 'package:marvel_universe/core/colors.dart';
import 'package:marvel_universe/features/characters/presentation/characters_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marvel Universe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorsApp.primaryColor),
        useMaterial3: true,
      ),
      home: const CharactersPage(),
    );
  }
}
