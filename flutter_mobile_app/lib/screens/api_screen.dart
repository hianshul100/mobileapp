import 'package:flutter/material.dart';

import '../services/api_service.dart';

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
            children: topics
                .map(
                  (topic) => Card(
                    child: ListTile(
                      title: Text(topic.title),
                      subtitle: Text(topic.summary),
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
