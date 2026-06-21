import 'package:flutter/material.dart';

import '../services/local_storage_service.dart';
import '../theme/skillforge_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _dailyReminder = true;
  bool _pushAlerts = true;

  Future<void> _saveSettings() async {
    await LocalStorageService.saveSettings({
      'dailyReminder': _dailyReminder,
      'pushAlerts': _pushAlerts,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SkillCard(
            child: SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Daily reminder'),
              subtitle: const Text('8:00 AM'),
              value: _dailyReminder,
              onChanged: (value) {
                setState(() => _dailyReminder = value);
                _saveSettings();
              },
              activeColor: skillGreen,
            ),
          ),
          SkillCard(
            child: SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Push alerts'),
              subtitle: const Text('Lesson and streak updates'),
              value: _pushAlerts,
              onChanged: (value) {
                setState(() => _pushAlerts = value);
                _saveSettings();
              },
              activeColor: skillGreen,
            ),
          ),
        ],
      ),
    );
  }
}
