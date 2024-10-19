import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/habit.dart';
import '../bloc/habit_bloc.dart';
import '../bloc/habit_event.dart';

class AddHabitScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Ein neues Habit-Objekt erstellen
                    Habit newHabit = Habit(
                      id: '', // Firestore erstellt die ID
                      name: _nameController.text,
                      startDate: DateTime.now(),
                      completionStatus: [],
                    );
                    // Das AddHabit-Event an den BLoC senden
                    context.read<HabitBloc>().add(AddHabit(newHabit));
                    // Zurück zum Home-Screen navigieren
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
