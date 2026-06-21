import 'package:flutter/material.dart';

import '../services/local_storage_service.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import '../theme/skillforge_theme.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() => _error = 'Username, email, and password are required.');
      return;
    }

    if (!email.contains('@')) {
      setState(() => _error = 'Enter a valid email address.');
      return;
    }

    await LocalStorageService.saveSignup(
      username: username,
      email: email,
      password: password,
    );

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 96, 24, 24),
        children: [
          Text(
            'Create account',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Start saving lessons and reminders.',
            style: TextStyle(color: skillMuted),
          ),
          const SizedBox(height: 28),
          TextField(
            controller: _usernameController,
            decoration: skillInputDecoration('Username'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _emailController,
            decoration: skillInputDecoration('Email'),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _passwordController,
            decoration: skillInputDecoration('Password'),
            obscureText: true,
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(_error!, style: const TextStyle(color: Colors.red)),
          ],
          const SizedBox(height: 20),
          FilledButton(
            style: skillButtonStyle(),
            onPressed: _signup,
            child: const Text('Sign up'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
            child: const Text(
              'Already have an account? Login',
              style: TextStyle(color: skillGreen, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
