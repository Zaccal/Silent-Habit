import 'package:flutter/material.dart';

class DayItem extends StatelessWidget {
  final String dayName;
  final String dayNumber;
  final bool isSelected;

  const DayItem({
    super.key,
    required this.dayName,
    required this.dayNumber,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          dayName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        const SizedBox(height: 8),
        Container(
          width: 45,
          height: 90,
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF8B9467)
                : const Color(0xFFF2F4E3),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Точка сверху
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white70 : Colors.black26,
                  shape: BoxShape.circle,
                ),
              ),
              // Число
              Text(
                dayNumber,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
