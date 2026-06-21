import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'country_list.dart';
import 'habit_tracker_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _ageController = TextEditingController();
  final Set<String> _selectedHabits = <String>{};
  final Map<String, int> _habitColors = <String, int>{};
  final Random _random = Random();

  List<String> _countries = const [];
  String? _selectedCountry;

  final List<String> _availableHabits = const [
    'Drink Water',
    'Read',
    'Exercise',
    'Meditate',
    'Sleep Early',
    'Walk',
    'Journal',
  ];

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _loadCountries() async {
    final countries = await fetchCountries();

    if (!mounted) return;
    setState(() {
      _countries = countries;
      _selectedCountry = countries.isNotEmpty ? countries.first : null;
    });
  }

  Color _generateHabitColor() {
    final colors = <Color>[
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.teal,
      Colors.indigo,
    ];

    return colors[_random.nextInt(colors.length)];
  }

  void _toggleHabitSelection(String habit) {
    setState(() {
      if (_selectedHabits.contains(habit)) {
        _selectedHabits.remove(habit);
        _habitColors.remove(habit);
      } else {
        _selectedHabits.add(habit);
        _habitColors[habit] = _generateHabitColor().value;
      }
    });
  }

  Future<void> _register() async {
    final name = _nameController.text.trim();
    final username = _usernameController.text.trim();
    final age = double.tryParse(_ageController.text.trim());

    if (name.isEmpty ||
        username.isEmpty ||
        age == null ||
        _selectedCountry == null ||
        _selectedHabits.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please complete all fields and select at least one habit',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    final habits = _selectedHabits
        .map(
          (habit) => {
            'name': habit,
            'colorValue': _habitColors[habit] ?? Colors.blue.value,
            'completed': false,
          },
        )
        .toList();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('username', username);
    await prefs.setDouble('age', age);
    await prefs.setString('country', _selectedCountry!);
    await prefs.setString('habit.habits', jsonEncode(habits));

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HabitTrackerScreen(username: username),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade700, Colors.blue.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _RegisterTextField(
                    controller: _nameController,
                    hintText: 'Enter Name',
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 16),
                  _RegisterTextField(
                    controller: _usernameController,
                    hintText: 'Enter Username',
                    icon: Icons.account_circle,
                  ),
                  const SizedBox(height: 16),
                  _RegisterTextField(
                    controller: _ageController,
                    hintText: 'Enter Age',
                    icon: Icons.cake,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedCountry,
                        hint: const Text('Select Country'),
                        items: _countries
                            .map(
                              (country) => DropdownMenuItem(
                                value: country,
                                child: Text(country),
                              ),
                            )
                            .toList(),
                        onChanged: (country) {
                          if (country != null) {
                            setState(() => _selectedCountry = country);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select Habits',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ..._availableHabits.map(
                    (habit) {
                      final selected = _selectedHabits.contains(habit);
                      final colorValue = _habitColors[habit] ?? Colors.white.value;

                      return Card(
                        child: CheckboxListTile(
                          value: selected,
                          onChanged: (_) => _toggleHabitSelection(habit),
                          title: Text(habit),
                          secondary: CircleAvatar(
                            backgroundColor: selected
                                ? Color(colorValue)
                                : Colors.grey.shade300,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 80,
                        vertical: 15,
                      ),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Already have an account? Log in',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterTextField extends StatelessWidget {
  const _RegisterTextField({
    required this.controller,
    required this.hintText,
    required this.icon,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blue.shade700),
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
      ),
    );
  }
}
