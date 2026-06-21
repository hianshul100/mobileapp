class Lesson {
  const Lesson({
    required this.id,
    required this.title,
    required this.level,
    required this.minutes,
    required this.summary,
  });

  final int id;
  final String title;
  final String level;
  final int minutes;
  final String summary;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'level': level,
      'minutes': minutes,
      'summary': summary,
    };
  }

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as int,
      title: json['title'] as String,
      level: json['level'] as String,
      minutes: json['minutes'] as int,
      summary: json['summary'] as String,
    );
  }
}

const lessons = [
  Lesson(
    id: 1,
    title: 'React Native Basics',
    level: 'Beginner',
    minutes: 18,
    summary: 'Build reusable components for mobile screens.',
  ),
  Lesson(
    id: 2,
    title: 'Persisting Favorites',
    level: 'Intermediate',
    minutes: 22,
    summary: 'Store selected lessons with local persistence.',
  ),
  Lesson(
    id: 3,
    title: 'API Data UX',
    level: 'Intermediate',
    minutes: 25,
    summary: 'Fetch remote data and show useful loading states.',
  ),
];
