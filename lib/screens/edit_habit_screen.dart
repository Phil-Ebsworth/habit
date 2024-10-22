import 'package:flutter/material.dart';
import '../models/habit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/habit_bloc.dart';
import '../bloc/habit_event.dart';
import 'package:intl/intl.dart'; // Für die Formatierung des Datums

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
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.habit.name);
    _isPositive = widget.habit.isPositive;
    _selectedDate = widget.habit.startDate;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // Methode zur Auswahl des Startdatums
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Habit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                textAlign: TextAlign.center,
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a habit name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'Start Date: ${DateFormat.yMMMd().format(_selectedDate)}'),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Relapses: ${widget.habit.relapseCount}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'Days completed: ${widget.habit.completionStatus.where((status) => status).length}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              // Speichern-Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Aktualisiertes Habit erstellen
                    final updatedHabit = Habit(
                      id: widget.habit.id,
                      name: _nameController.text,
                      startDate: widget.habit.startDate,
                      completionStatus: widget.habit.completionStatus,
                      isPositive: _isPositive,
                      relapseCount: widget.habit.relapseCount,
                      relapseDate: widget.habit.relapseDate,
                      completionDate: widget.habit.completionDate,
                    );

                    // Sende das aktualisierte Habit an den BLoC
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
