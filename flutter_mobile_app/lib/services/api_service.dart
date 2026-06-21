import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiTopic {
  const ApiTopic({required this.title, required this.summary});

  final String title;
  final String summary;
}

class ApiService {
  static Future<List<ApiTopic>> fetchTopics() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=5'),
    );

    if (response.statusCode != 200) {
      throw Exception('Unable to load API learning topics.');
    }

    final decoded = jsonDecode(response.body) as List<dynamic>;
    return decoded
        .map(
          (item) => ApiTopic(
            title: item['title'] as String,
            summary: item['body'] as String,
          ),
        )
        .toList();
  }
}
