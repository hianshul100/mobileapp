import 'package:flutter/material.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Learning reminders are enabled.'),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _sendTestNotification,
              child: const Text('Send test notification'),
            ),
            if (_message != null) ...[
              const SizedBox(height: 20),
              Text(_message!, style: const TextStyle(color: Colors.green)),
            ],
          ],
        ),
      ),
    );
  }
}
