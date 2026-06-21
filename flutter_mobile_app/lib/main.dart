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
      builder: (context, child) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFF0A8), Color(0xFFFFB2C8), Color(0xFFB6F2FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Container(
              width: 390,
              height: 800,
              decoration: BoxDecoration(
                color: skillSurface,
                borderRadius: BorderRadius.circular(34),
                border: Border.all(color: skillInk, width: 12),
                boxShadow: [
                  BoxShadow(
                    color: skillViolet.withOpacity(0.25),
                    blurRadius: 45,
                    offset: const Offset(0, 18),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: child ?? const SizedBox.shrink(),
              ),
            ),
          ),
        );
      },
      home: const LoginScreen(),
    );
  }
}
