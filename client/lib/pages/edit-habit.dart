import 'package:flutter/material.dart';
import 'package:silent_habit/api/api.dart';
import 'package:silent_habit/models/habit.dart';

class EditHabitPage extends StatefulWidget {
  final Habit habit;
  final Function(Habit) onUpdate;
  const EditHabitPage({super.key, required this.habit, required this.onUpdate});

  @override
  State<EditHabitPage> createState() => _EditHabitPageState();
}

class _EditHabitPageState extends State<EditHabitPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _descController;
  final Api _api = Api();
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.habit.name);
    _descController = TextEditingController(text: widget.habit.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _submitData() async {
    setState(() => _isUpdating = true);
    setState(() => _isUpdating = false);

    final updatedHabit = Habit(
      id: widget.habit.id,
      name: _nameController.text,
      description: _descController.text,
    );

    await _api.updateHabit(updatedHabit);
    await widget.onUpdate(updatedHabit);

    if (mounted) Navigator.pop(context, true);
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
            _isUpdating
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
