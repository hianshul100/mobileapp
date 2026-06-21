import 'package:flutter/material.dart';

import '../services/local_storage_service.dart';

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
        children: [
          SwitchListTile(
            title: const Text('Daily reminder'),
            value: _dailyReminder,
            onChanged: (value) {
              setState(() => _dailyReminder = value);
              _saveSettings();
            },
          ),
          SwitchListTile(
            title: const Text('Push alerts'),
            value: _pushAlerts,
            onChanged: (value) {
              setState(() => _pushAlerts = value);
              _saveSettings();
            },
          ),
        ],
      ),
    );
  }
}
