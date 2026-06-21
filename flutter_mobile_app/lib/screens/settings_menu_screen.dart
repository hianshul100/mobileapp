import 'package:flutter/material.dart';

import 'notifications_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import '../theme/skillforge_theme.dart';

class SettingsMenuScreen extends StatelessWidget {
  const SettingsMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings menu')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SkillCard(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
            child: const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.person, color: skillViolet),
              title: Text('Profile'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          SkillCard(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
            child: const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.settings, color: skillCoral),
              title: Text('Settings'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          SkillCard(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationsScreen()),
            ),
            child: const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.notifications, color: skillSky),
              title: Text('Notifications'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
    );
  }
}
