import 'package:flutter/material.dart';

import '../models/lesson.dart';
import '../services/local_storage_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? _user;
  List<Lesson> _favorites = const [];

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final user = await LocalStorageService.loadUser();
    final favorites = await LocalStorageService.loadFavorites();
    if (!mounted) return;
    setState(() {
      _user = user;
      _favorites = favorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites/Profile')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(_user?['username']?.toString() ?? 'Learner'),
          Text(_user?['email']?.toString() ?? 'No email saved'),
          const SizedBox(height: 20),
          Text('Favorites', style: Theme.of(context).textTheme.titleLarge),
          ..._favorites.map(
            (lesson) => ListTile(
              leading: const Icon(Icons.star),
              title: Text(lesson.title),
              subtitle: Text('Persisted locally'),
            ),
          ),
        ],
      ),
    );
  }
}
