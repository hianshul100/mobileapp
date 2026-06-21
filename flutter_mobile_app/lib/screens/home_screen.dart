import 'package:flutter/material.dart';

import '../models/lesson.dart';
import 'api_screen.dart';
import 'detail_screen.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'settings_menu_screen.dart';
import '../theme/skillforge_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: skillViolet,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsMenuScreen()),
            );
          },
        ),
        title: const Text(
          'SkillForge',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.api),
          color: skillCoral,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ApiScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            color: skillViolet,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            color: skillCoral,
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SkillPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Today', style: TextStyle(color: skillMuted)),
                const SizedBox(height: 8),
                Text(
                  'Keep your learning streak alive',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 14),
                FilledButton(
                  style: skillButtonStyle(),
                  onPressed: () {},
                  child: const Text('Resume lesson'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton.icon(
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            ),
          ),
          const SizedBox(height: 16),
          ...lessons.map(
            (lesson) => SkillCard(
              onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(lesson: lesson),
                    ),
                  );
              },
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lesson.title,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          '${lesson.level} - ${lesson.minutes} min',
                          style: const TextStyle(color: skillMuted),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: skillCoral),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
