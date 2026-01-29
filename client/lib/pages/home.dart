import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:silent_habit/api/api.dart';
import 'package:silent_habit/components/habit_widget.dart';
import 'package:silent_habit/components/header.dart';
import 'package:silent_habit/components/week-day.dart';
import 'package:silent_habit/models/habit.dart';
import 'package:silent_habit/pages/add-habit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Habit>> _habitsFuture;
  final Api _api = Api();

  List<DateTime> getCurrentWeek() {
    DateTime now = DateTime.now();
    DateTime firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return List.generate(
      7,
      (index) => firstDayOfWeek.add(Duration(days: index)),
    );
  }

  @override
  void initState() {
    super.initState();
    _habitsFuture = _api.fetchHabits();
  }

  void _refreshHabits() {
    setState(() {
      _habitsFuture = _api.fetchHabits();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<DateTime> weekDays = getCurrentWeek();
    final DateTime today = DateTime.now();

    return Scaffold(
      backgroundColor: HexColor('#F6F0D7'),
      // Only ONE Scaffold at the top level
      body: Column(
        children: [
          Header(dayNumber: 3),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: weekDays.map((date) {
                bool isToday =
                    date.day == today.day &&
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
          // FIX: Wrap the FutureBuilder area in Expanded
          Expanded(
            child: FutureBuilder<List<Habit>>(
              future: _habitsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Ошибка: ${snapshot.error}'));
                }

                if (snapshot.hasData) {
                  final habits = snapshot.data!;
                  if (habits.isEmpty) {
                    return const Center(child: Text('Список пуст'));
                  }

                  return ListView.builder(
                    // Important: Add padding so the last item isn't hidden by the FAB
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: habits.length,
                    itemBuilder: (context, index) {
                      final habit = habits[index];
                      return HabitWidget(habit: habit);
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddHabitPage()),
          );

          if (result == true) {
            _refreshHabits();
          }
        },
        backgroundColor: const Color(0xFF8B9467),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
