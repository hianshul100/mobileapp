import 'package:flutter/material.dart';

import 'add_habit_screen.dart';
import 'habit_storage.dart';

class HabitTrackerScreen extends StatefulWidget {
  const HabitTrackerScreen({super.key});

  @override
  State<HabitTrackerScreen> createState() => _HabitTrackerScreenState();
}

class _HabitTrackerScreenState extends State<HabitTrackerScreen> {
  List<HabitItem> _habits = const [];
  Map<String, String> _user = const {};

  @override
  void initState() {
    super.initState();
    _loadStoredData();
  }

  Future<void> _loadStoredData() async {
    final user = await HabitStorage.loadUser();
    final habits = await HabitStorage.loadHabits();

    if (!mounted) return;
    setState(() {
      _user = user;
      _habits = habits;
    });
  }

  Future<void> _toggleCompleted(HabitItem habit, bool completed) async {
    final updatedHabits = _habits
        .map(
          (item) => item.name == habit.name
              ? item.copyWith(completed: completed)
              : item,
        )
        .toList();

    await HabitStorage.saveHabits(updatedHabits);
    setState(() => _habits = updatedHabits);
  }

  Future<void> _openAddHabit() async {
    final added = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const AddHabitScreen()),
    );

    if (added == true) {
      await _loadStoredData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final incompleteHabits =
        _habits.where((habit) => !habit.completed).toList();
    final completedHabits = _habits.where((habit) => habit.completed).toList();
    final displayName = _user['shortUserName']?.isNotEmpty == true
        ? _user['shortUserName']!
        : 'Habit User';

    return Scaffold(
      appBar: AppBar(
        title: Text('$displayName habits'),
        actions: [
          IconButton(
            onPressed: _openAddHabit,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Incomplete habits',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          if (incompleteHabits.isEmpty)
            const Text('No incomplete habits. Nice work.'),
          ...incompleteHabits.map((habit) => _HabitTile(
                habit: habit,
                onChanged: (completed) => _toggleCompleted(habit, completed),
              )),
          const SizedBox(height: 24),
          Text(
            'Completed habits',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          if (completedHabits.isEmpty) const Text('No completed habits yet.'),
          ...completedHabits.map((habit) => _HabitTile(
                habit: habit,
                onChanged: (completed) => _toggleCompleted(habit, completed),
              )),
        ],
      ),
    );
  }
}

class _HabitTile extends StatelessWidget {
  const _HabitTile({
    required this.habit,
    required this.onChanged,
  });

  final HabitItem habit;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CheckboxListTile(
        value: habit.completed,
        onChanged: (completed) => onChanged(completed ?? false),
        title: Text(habit.name),
        secondary: CircleAvatar(backgroundColor: habit.color),
      ),
    );
  }
}
