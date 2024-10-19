import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/habit.dart';
import '../bloc/habit_bloc.dart';
import '../bloc/habit_event.dart';

class AddHabitScreen extends StatefulWidget {
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
        title: Text('Add Habit'),
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
                    // Neues Habit erstellen
                    Habit newHabit = Habit(
                      id: '',
                      name: _nameController.text,
                      startDate: DateTime.now(),
                      completionStatus: [],
                      isPositive: _isPositive, // Gewohnheitstyp
                    );
                    // Event zum Hinzufügen der Gewohnheit senden
                    context.read<HabitBloc>().add(AddHabit(newHabit));
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Habit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
