import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../theme/skillforge_theme.dart';

class ApiScreen extends StatelessWidget {
  const ApiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('External API')),
      body: FutureBuilder<List<ApiTopic>>(
        future: ApiService.fetchTopics(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Unable to load API data.'));
          }

          final topics = snapshot.data ?? const [];
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              SkillPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Fetched from JSONPlaceholder API',
                      style: TextStyle(color: skillMuted),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Fresh learning topics',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ...topics.map(
                (topic) => SkillCard(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(topic.title),
                    subtitle: Text(topic.summary),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
