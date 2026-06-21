import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'theme/skillforge_theme.dart';

void main() {
  runApp(const SkillForgeApp());
}

class SkillForgeApp extends StatelessWidget {
  const SkillForgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkillForge',
      theme: ThemeData(
        scaffoldBackgroundColor: skillSurface,
        colorScheme: ColorScheme.fromSeed(
          seedColor: skillGreen,
          primary: skillGreen,
          surface: skillSurface,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: skillSurface,
          foregroundColor: skillInk,
          centerTitle: true,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: skillBorder),
          ),
        ),
        textTheme: ThemeData.light().textTheme.apply(
              bodyColor: skillInk,
              displayColor: skillInk,
            ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
