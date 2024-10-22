import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/habit.dart';
import '../bloc/habit_bloc.dart';
import '../bloc/habit_event.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  _AddHabitScreenState createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  bool _isPositive = true; // Standardmäßig positive Gewohnheit

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Habit'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Habit Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a habit name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Auswahlfeld für positive oder negative Gewohnheit
              Row(
                children: [
                  const Text('Type: '),
                  DropdownButton<bool>(
                    value: _isPositive,
                    items: const [
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Neues Habit erstellen
                    Habit newHabit = Habit(
                      id: '',
                      name: _nameController.text,
                      startDate: DateTime.now(),
                      completionStatus: [],
                      isPositive: _isPositive,
                      relapseDate: DateTime(0),
                      completionDate: DateTime(0),
                    );
                    // Event zum Hinzufügen der Gewohnheit senden
                    context.read<HabitBloc>().add(AddHabit(newHabit));
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Habit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
