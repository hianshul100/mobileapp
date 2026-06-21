import 'package:flutter/material.dart';

import 'habit_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _shortUserNameController = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _userNameController.dispose();
    _shortUserNameController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final userName = _userNameController.text.trim();
    final shortUserName = _shortUserNameController.text.trim();

    if (userName.isEmpty || shortUserName.isEmpty) {
      setState(() => _error = 'Enter your name and short username.');
      return;
    }

    await HabitStorage.saveUser(
      userName: userName,
      shortUserName: shortUserName,
    );

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/habits');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Habit Login')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: _userNameController,
            decoration: const InputDecoration(labelText: 'User name'),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _shortUserNameController,
            decoration: const InputDecoration(labelText: 'Short username'),
            textInputAction: TextInputAction.done,
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(_error!, style: const TextStyle(color: Colors.red)),
          ],
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _login,
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/register'),
            child: const Text('Create account'),
          ),
        ],
      ),
    );
  }
}
