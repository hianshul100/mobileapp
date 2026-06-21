import 'package:flutter/material.dart';

import '../models/lesson.dart';
import 'api_screen.dart';
import 'detail_screen.dart';
import 'profile_screen.dart';
import 'settings_menu_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsMenuScreen()),
            );
          },
        ),
        title: const Text('SkillForge'),
        actions: [
          IconButton(
            icon: const Icon(Icons.api),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ApiScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Keep your learning streak alive',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          ...lessons.map(
            (lesson) => Card(
              child: ListTile(
                title: Text(lesson.title),
                subtitle: Text('${lesson.level} - ${lesson.minutes} min'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(lesson: lesson),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
