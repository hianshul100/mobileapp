import 'package:flutter/material.dart';

import '../services/local_storage_service.dart';
import 'home_screen.dart';
import 'signup_screen.dart';
import '../theme/skillforge_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final isValid = await LocalStorageService.validateLogin(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (!isValid) {
      setState(() => _error = 'No learner account matches those credentials.');
      return;
    }

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
        padding: const EdgeInsets.fromLTRB(24, 140, 24, 24),
        children: [
          Text(
            'Welcome back',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Continue your saved learning plan.',
            style: TextStyle(color: skillMuted),
          ),
          const SizedBox(height: 28),
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
            onPressed: _login,
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const SignupScreen()),
              );
            },
            child: const Text(
              'Need an account? Sign up',
              style: TextStyle(color: skillGreen, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
