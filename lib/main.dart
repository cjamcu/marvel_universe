import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marvel_universe/core/colors.dart';
import 'package:marvel_universe/features/characters/presentation/characters_page.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"  );
  await di.init();
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
      debugShowCheckedModeBanner: false,
      home:  const CharactersPage(),
    );
  }
}
