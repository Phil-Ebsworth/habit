import 'package:flutter/material.dart';
import '../models/habit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/habit_bloc.dart';
import '../bloc/habit_event.dart';

class EditHabitScreen extends StatefulWidget {
  final Habit habit;

  EditHabitScreen({required this.habit});

  @override
  _EditHabitScreenState createState() => _EditHabitScreenState();
}

class _EditHabitScreenState extends State<EditHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late bool _isPositive;
  late String _habit_id;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.habit.name);
    _isPositive = widget.habit.isPositive;
    _habit_id = widget.habit.id;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Habit'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<HabitBloc>().add(DeleteHabit(_habit_id));
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Habit Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a habit name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Auswahlfeld für positive oder negative Gewohnheit
              Row(
                children: [
                  Text('Type: '),
                  DropdownButton<bool>(
                    value: _isPositive,
                    items: [
                      DropdownMenuItem(value: true, child: Text('Learn')),
                      DropdownMenuItem(value: false, child: Text('Unlearn')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _isPositive = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Aktuelles Habit mit den geänderten Werten aktualisieren
                    final updatedHabit = Habit(
                      id: widget.habit.id,
                      name: _nameController.text,
                      startDate: widget.habit.startDate,
                      completionStatus: widget.habit.completionStatus,
                      isPositive: _isPositive,
                      relapseCount: widget.habit.relapseCount,
                    );
                    // Event zum Aktualisieren des Habits senden
                    context.read<HabitBloc>().add(UpdateHabit(updatedHabit));
                    Navigator.pop(context); // Zurück zum vorherigen Bildschirm
                  }
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
