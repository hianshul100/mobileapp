import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/lesson.dart';

class LocalStorageService {
  static const userKey = 'skillforge.user';
  static const passwordKey = 'skillforge.password';
  static const favoritesKey = 'skillforge.favorites';
  static const settingsKey = 'skillforge.settings';

  static Future<void> saveSignup({
    required String username,
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      userKey,
      jsonEncode({'username': username, 'email': email}),
    );
    await prefs.setString(passwordKey, password);
  }

  static Future<Map<String, dynamic>?> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final rawUser = prefs.getString(userKey);
    if (rawUser == null) return null;
    return jsonDecode(rawUser) as Map<String, dynamic>;
  }

  static Future<bool> validateLogin({
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final user = await loadUser();
    return user?['email'] == email && prefs.getString(passwordKey) == password;
  }

  static Future<List<Lesson>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final rawFavorites = prefs.getString(favoritesKey) ?? '[]';
    final decoded = jsonDecode(rawFavorites) as List<dynamic>;
    return decoded
        .map((item) => Lesson.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  static Future<void> saveFavorite(Lesson lesson) async {
    final favorites = await loadFavorites();
    if (!favorites.any((item) => item.id == lesson.id)) {
      favorites.add(lesson);
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      favoritesKey,
      jsonEncode(favorites.map((lesson) => lesson.toJson()).toList()),
    );
  }

  static Future<void> saveSettings(Map<String, dynamic> settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(settingsKey, jsonEncode(settings));
  }
}
