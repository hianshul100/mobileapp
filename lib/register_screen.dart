import 'package:flutter/material.dart';

import 'country_list.dart';
import 'habit_storage.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _shortUserNameController = TextEditingController();
  final Set<String> _selectedHabits = <String>{};
  List<String> _countries = const [];
  String? _selectedCountry;
  String? _error;

  final List<String> _starterHabits = const [
    'Drink Water',
    'Read',
    'Exercise',
    'Meditate',
    'Sleep Early',
  ];

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _shortUserNameController.dispose();
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

  Future<void> _register() async {
    final userName = _userNameController.text.trim();
    final shortUserName = _shortUserNameController.text.trim();

    if (userName.isEmpty || shortUserName.isEmpty || _selectedHabits.isEmpty) {
      setState(() {
        _error = 'Enter user details and choose at least one habit.';
      });
      return;
    }

    await HabitStorage.saveUser(
      userName: userName,
      shortUserName: shortUserName,
      country: _selectedCountry,
    );

    await HabitStorage.saveHabits(
      _selectedHabits
          .map(
            (habit) => HabitItem(
              name: habit,
              colorValue: Colors.teal.value,
            ),
          )
          .toList(),
    );

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/habits');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: _userNameController,
            decoration: const InputDecoration(labelText: 'User name'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _shortUserNameController,
            decoration: const InputDecoration(labelText: 'Short username'),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _selectedCountry,
            decoration: const InputDecoration(labelText: 'Country'),
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
          const SizedBox(height: 20),
          const Text('Select habits'),
          const SizedBox(height: 8),
          ..._starterHabits.map(
            (habit) => CheckboxListTile(
              title: Text(habit),
              value: _selectedHabits.contains(habit),
              onChanged: (selected) {
                setState(() {
                  if (selected == true) {
                    _selectedHabits.add(habit);
                  } else {
                    _selectedHabits.remove(habit);
                  }
                });
              },
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(_error!, style: const TextStyle(color: Colors.red)),
          ],
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _register,
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
