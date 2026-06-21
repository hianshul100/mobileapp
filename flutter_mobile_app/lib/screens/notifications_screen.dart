import 'package:flutter/material.dart';
import '../theme/skillforge_theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String? _message;

  void _sendTestNotification() {
    setState(() {
      _message = 'Test notification sent successfully.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SkillPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Learning reminders',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 8),
              const Text('Daily reminder enabled. Push alerts configured.'),
              const SizedBox(height: 20),
              FilledButton(
                style: skillButtonStyle(),
                onPressed: _sendTestNotification,
                child: const Text('Send test notification'),
              ),
              if (_message != null) ...[
                const SizedBox(height: 20),
                Text(_message!, style: const TextStyle(color: skillViolet)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
