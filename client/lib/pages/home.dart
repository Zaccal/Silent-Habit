import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:silent_habit/api/api.dart';
import 'package:silent_habit/components/habit.dart';
import 'package:silent_habit/components/header.dart';
import 'package:silent_habit/components/week-day.dart';
import 'package:silent_habit/models/post.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> _posts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    try {
      final posts = await Api().fetchPosts();
      setState(() {
        _posts = posts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error, maybe show a snackbar
      print(e);
    }
  }

  List<DateTime> getCurrentWeek() {
    DateTime now = DateTime.now();
    DateTime firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return List.generate(
      7,
      (index) => firstDayOfWeek.add(Duration(days: index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<DateTime> weekDays = getCurrentWeek();
    final DateTime today = DateTime.now();

    return Scaffold(
      backgroundColor: HexColor('#F6F0D7'),
      body: Column(
        children: [
          Header(dayNumber: 3),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: weekDays.map((date) {
                bool isToday = date.day == today.day &&
                    date.month == today.month &&
                    date.year == today.year;

                return DayItem(
                  dayName: DateFormat('E').format(date)[0],
                  dayNumber: date.day.toString(),
                  isSelected: isToday,
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _posts.length,
                    itemBuilder: (context, index) {
                      return Habit(post: _posts[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF8B9467),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}