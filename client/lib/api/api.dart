import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:silent_habit/models/habit.dart';

const API_URL = 'http://localhost:8080';

class Api {
  Future<List<Habit>> fetchHabits() async {
    final uri = Uri.parse('$API_URL/habits');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> habitsData = json.decode(response.body);
      return habitsData.map((json) => Habit.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load habits');
    }
  }

  Future<Habit> addHabit(Habit habit) async {
    final uri = Uri.parse('$API_URL/habits');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': habit.name, 'description': habit.description}),
    );
    if (response.statusCode == 200) {
      return Habit.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add habit');
    }
  }

  Future<void> deleteHabit(String id) async {
    final uri = Uri.parse('$API_URL/habits?id=$id');
    final response = await http.delete(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete habit');
    }
  }

  Future<Habit> updateHabit(Habit habit) async {
    final uri = Uri.parse('$API_URL/habits?id=${habit.id}');
    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': habit.name, 'description': habit.description}),
    );
    if (response.statusCode == 200) {
      return Habit.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update habit');
    }
  }
}
