import 'package:flutter/material.dart';

import '../models/lesson.dart';
import '../services/local_storage_service.dart';
import '../theme/skillforge_theme.dart';

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
          CircleAvatar(
            radius: 36,
            backgroundColor: skillGold,
            child: Text(
              (_user?['username']?.toString().isNotEmpty == true)
                  ? _user!['username'].toString()[0].toUpperCase()
                  : 'L',
              style: const TextStyle(
                color: skillInk,
                fontWeight: FontWeight.w900,
                fontSize: 26,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _user?['username']?.toString() ?? 'Learner',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          Text(
            _user?['email']?.toString() ?? 'No email saved',
            style: const TextStyle(color: skillMuted),
          ),
          const SizedBox(height: 20),
          Text('Favorites', style: Theme.of(context).textTheme.titleLarge),
          if (_favorites.isEmpty)
            const SkillCard(
              child: Text('No favorites yet. Save a lesson from the detail screen.'),
            ),
          ..._favorites.map(
            (lesson) => SkillCard(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.star, color: skillCoral),
                title: Text(lesson.title),
                subtitle: const Text('Persisted locally'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
