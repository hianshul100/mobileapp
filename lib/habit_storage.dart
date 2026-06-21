import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HabitItem {
  const HabitItem({
    required this.name,
    required this.colorValue,
    this.completed = false,
  });

  final String name;
  final int colorValue;
  final bool completed;

  Color get color => Color(colorValue);

  HabitItem copyWith({String? name, int? colorValue, bool? completed}) {
    return HabitItem(
      name: name ?? this.name,
      colorValue: colorValue ?? this.colorValue,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'colorValue': colorValue,
      'completed': completed,
    };
  }

  factory HabitItem.fromJson(Map<String, dynamic> json) {
    return HabitItem(
      name: json['name'] as String,
      colorValue: json['colorValue'] as int,
      completed: json['completed'] as bool? ?? false,
    );
  }
}

class HabitStorage {
  static const userNameKey = 'habit.userName';
  static const shortUserNameKey = 'habit.shortUserName';
  static const countryKey = 'habit.country';
  static const habitsKey = 'habit.habits';

  static Future<void> saveUser({
    required String userName,
    required String shortUserName,
    String? country,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userNameKey, userName);
    await prefs.setString(shortUserNameKey, shortUserName);

    if (country != null) {
      await prefs.setString(countryKey, country);
    }
  }

  static Future<Map<String, String>> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'userName': prefs.getString(userNameKey) ?? '',
      'shortUserName': prefs.getString(shortUserNameKey) ?? '',
      'country': prefs.getString(countryKey) ?? '',
    };
  }

  static Future<void> saveHabits(List<HabitItem> habits) async {
    final prefs = await SharedPreferences.getInstance();
    final habitJson = habits.map((habit) => habit.toJson()).toList();
    await prefs.setString(habitsKey, jsonEncode(habitJson));
  }

  static Future<List<HabitItem>> loadHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final habitJson = prefs.getString(habitsKey);

    if (habitJson == null || habitJson.isEmpty) {
      return const [];
    }

    final decoded = jsonDecode(habitJson) as List<dynamic>;
    return decoded
        .map((item) => HabitItem.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
