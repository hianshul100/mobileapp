import 'package:flutter/material.dart';

import '../models/lesson.dart';
import '../services/local_storage_service.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.lesson});

  final Lesson lesson;

  Future<void> _saveFavorite(BuildContext context) async {
    await LocalStorageService.saveFavorite(lesson);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saved to Favorites')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lesson detail')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${lesson.level} - ${lesson.minutes} min'),
            const SizedBox(height: 12),
            Text(lesson.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Text(lesson.summary),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () => _saveFavorite(context),
              icon: const Icon(Icons.favorite),
              label: const Text('Save to Favorites'),
            ),
          ],
        ),
      ),
    );
  }
}
