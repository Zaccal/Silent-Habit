import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:silent_habit/components/header.dart';
import 'package:silent_habit/components/week-day.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
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
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 7,
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
        ],
      ),
    );
  }
}
