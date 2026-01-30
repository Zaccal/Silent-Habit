import 'package:flutter/material.dart';
import 'package:silent_habit/api/api.dart';
import 'package:silent_habit/models/habit.dart' as model;
import 'package:silent_habit/pages/edit-habit.dart';

const image_url =
    "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fstatic.vecteezy.com%2Fsystem%2Fresources%2Fpreviews%2F000%2F360%2F297%2Foriginal%2Fvector-landscape-illustration.png&f=1&nofb=1&ipt=ba941c91fbcd7b2a299644d0935bcb27283a8d9fd80e7fc9d2f64cc3b01fdaac";

class HabitWidget extends StatelessWidget {
  final model.Habit habit;
  final Api api;
  final VoidCallback onDelete;
  const HabitWidget({
    super.key,
    required this.habit,
    required this.api,
    required this.onDelete,
  });

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this habit?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditHabitPage()),
              ),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                api.deleteHabit(habit.id);
                onDelete();
                Navigator.pop(context);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9999),
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(image_url),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                habit.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(habit.description, style: const TextStyle(fontSize: 12)),
            ],
          ),

          const Spacer(),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'Delete') {
                _showDeleteDialog(context);
              } else if (value == 'Edit') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditHabitPage(),
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Edit', child: Text('Edit')),
              const PopupMenuItem(value: 'Delete', child: Text('Delete')),
            ],
          ),
        ],
      ),
    );
  }
}
