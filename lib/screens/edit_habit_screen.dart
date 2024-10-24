import 'package:flutter/material.dart';
import '../models/habit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/habit_bloc.dart';
import '../bloc/habit_event.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

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
  late Map<DateTime, List> _events;
  DateTime? _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.habit.name);
    _isPositive = widget.habit.isPositive;
    _selectedDate = widget.habit.startDate;
    _events = _generateEvents(widget.habit);
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
  }

  Map<DateTime, List> _generateEvents(Habit habit) {
    Map<DateTime, List> events = {};
    for (int i = 0; i < habit.completionStatus.length; i++) {
      if (habit.completionStatus[i]) {
        DateTime date = habit.startDate.add(Duration(days: i));
        events[date] = ['Completed'];
      }
    }
    // Füge ein Testereignis für den heutigen Tag hinzu
    DateTime today = DateTime.now();
    events[today] = ['Test Event'];
    return events;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Habit'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Habit Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a habit name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                SwitchListTile(
                  title: Text('Is Positive Habit'),
                  value: _isPositive,
                  onChanged: (bool value) {
                    setState(() {
                      _isPositive = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                ListTile(
                  title: Text(
                      'Start Date: ${DateFormat.yMd().format(_selectedDate)}'),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != _selectedDate) {
                      setState(() {
                        _selectedDate = picked;
                        _events = _generateEvents(widget.habit);
                      });
                    }
                  },
                ),
                SizedBox(height: 16.0),
                TableCalendar(
                  firstDay: _selectedDate,
                  lastDay: DateTime.now(),
                  focusedDay: _focusedDay!,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  eventLoader: (day) {
                    return _events[day] ?? [];
                  },
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      if (events.isNotEmpty) {
                        return Positioned(
                          right: 1,
                          bottom: 1,
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${events.length}',
                                style: TextStyle().copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                ),
                if (_selectedDay != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Selected Date: ${DateFormat.yMd().format(_selectedDay!)}\nStatus: ${_events[_selectedDay]?.isNotEmpty == true ? 'Completed' : 'Not Completed'}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Save the habit
                      BlocProvider.of<HabitBloc>(context).add(
                        UpdateHabit(
                          widget.habit.copyWith(
                            name: _nameController.text,
                            isPositive: _isPositive,
                            startDate: _selectedDate,
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
