import 'package:flutter/material.dart';
import 'package:silent_habit/models/habit.dart';
import 'package:silent_habit/api/api.dart';

class AddHabitPage extends StatefulWidget {
  const AddHabitPage({super.key});

  @override
  State<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final Api _api = Api();
  bool _isSaving = false;

  Future<void> _submitData() async {
    if (_nameController.text.isEmpty) return;

    setState(() => _isSaving = true);

    try {
      final newHabit = Habit(
        id: '',
        name: _nameController.text,
        description: _descController.text,
      );

      await _api.addHabit(newHabit);

      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Habit')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Habit Name'),
            ),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            _isSaving
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _submitData,
                    child: const Text('Save Habit'),
                  ),
          ],
        ),
      ),
    );
  }
}
