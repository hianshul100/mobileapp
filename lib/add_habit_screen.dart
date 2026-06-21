import 'package:flutter/material.dart';

import 'habit_storage.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final TextEditingController _habitController = TextEditingController();
  Color _selectedColor = Colors.teal;

  final List<Color> _habitColors = const [
    Colors.teal,
    Colors.indigo,
    Colors.orange,
    Colors.pink,
    Colors.green,
  ];

  @override
  void dispose() {
    _habitController.dispose();
    super.dispose();
  }

  Future<void> _saveHabit() async {
    final name = _habitController.text.trim();

    if (name.isEmpty) {
      return;
    }

    final habits = await HabitStorage.loadHabits();
    habits.add(
      HabitItem(
        name: name,
        colorValue: _selectedColor.value,
      ),
    );
    await HabitStorage.saveHabits(habits);

    if (!mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Habit')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: _habitController,
            decoration: const InputDecoration(labelText: 'Habit name'),
          ),
          const SizedBox(height: 20),
          const Text('Habit color'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            children: _habitColors
                .map(
                  (color) => ChoiceChip(
                    label: const SizedBox(width: 24, height: 24),
                    selected: _selectedColor.value == color.value,
                    backgroundColor: color.withOpacity(0.25),
                    selectedColor: color,
                    onSelected: (_) => setState(() => _selectedColor = color),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _saveHabit,
            child: const Text('Save habit'),
          ),
        ],
      ),
    );
  }
}
