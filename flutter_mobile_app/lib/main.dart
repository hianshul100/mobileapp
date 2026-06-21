import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1F6F5B)),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
