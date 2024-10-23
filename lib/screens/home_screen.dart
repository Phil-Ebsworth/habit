import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/habit.dart';
import '../bloc/habit_bloc.dart';
import '../bloc/habit_state.dart';
import 'package:intl/intl.dart';

class HomeScreenWithCalendar extends StatefulWidget {
  @override
  _HomeScreenWithCalendarState createState() => _HomeScreenWithCalendarState();
}

class _HomeScreenWithCalendarState extends State<HomeScreenWithCalendar> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<Habit>> _completedEvents =
      {}; // Map for completed habits per day
  Map<DateTime, List<Habit>> _startEvents = {}; // Map for habit start dates

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit Tracker Calendar'),
      ),
      body: BlocBuilder<HabitBloc, HabitState>(
        builder: (context, state) {
          if (state is HabitsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HabitsLoaded) {
            // Group habits by completion date and start date
            _completedEvents = _groupHabitsByCompletionDate(state.habits);
            _startEvents = _groupHabitsByStartDate(state.habits);

            return Column(
              children: [
                // Calendar widget
                TableCalendar(
                  firstDay: DateTime.utc(2000, 1, 1),
                  lastDay: DateTime.utc(2100, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  eventLoader: (day) {
                    // Load both completion and start events for the day
                    return [...?_completedEvents[day], ...?_startEvents[day]];
                  },
                  calendarStyle: CalendarStyle(
                    markerDecoration: BoxDecoration(
                      color: Colors.green, // Mark days with completed habits
                      shape: BoxShape.circle,
                    ),
                    // Decoration for the start date of habits
                    todayDecoration: BoxDecoration(
                      color: Colors.blueAccent, // Highlight habit start dates
                      shape: BoxShape.circle,
                    ),
                    markersMaxCount: 2, // Only show one marker per day
                  ),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      if (_startEvents.containsKey(date)) {
                        return Positioned(
                          right: 1,
                          bottom: 1,
                          child: _buildMarker(
                            color: Colors.blue, // Marker for start dates
                          ),
                        );
                      } else if (_completedEvents.containsKey(date)) {
                        return Positioned(
                          right: 1,
                          bottom: 1,
                          child: _buildMarker(
                            color: Colors.green, // Marker for completion dates
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: _buildHabitListForSelectedDay(),
                ),
              ],
            );
          } else if (state is HabitsError) {
            return Center(child: Text('Failed to load habits.'));
          }
          return Container();
        },
      ),
    );
  }

  // Build a custom marker for calendar events
  Widget _buildMarker({required Color color}) {
    return Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  // Group habits by their completion dates
  Map<DateTime, List<Habit>> _groupHabitsByCompletionDate(List<Habit> habits) {
    Map<DateTime, List<Habit>> habitEvents = {};
    for (var habit in habits) {
      for (var i = 0; i < habit.completionStatus.length; i++) {
        if (habit.completionStatus[i] == true) {
          DateTime completedDate = habit.startDate.add(Duration(days: i));
          if (habitEvents[completedDate] == null) {
            habitEvents[completedDate] = [];
          }
          habitEvents[completedDate]?.add(habit);
        }
      }
    }
    return habitEvents;
  }

  // Group habits by their start dates
  Map<DateTime, List<Habit>> _groupHabitsByStartDate(List<Habit> habits) {
    Map<DateTime, List<Habit>> startEvents = {};
    for (var habit in habits) {
      DateTime startDate = habit.startDate;
      if (startEvents[startDate] == null) {
        startEvents[startDate] = [];
      }
      startEvents[startDate]?.add(habit);
    }
    return startEvents;
  }

  // Show a list of habits completed or started on the selected day
  Widget _buildHabitListForSelectedDay() {
    final selectedEvents = [
      ...?_completedEvents[_selectedDay],
      ...?_startEvents[_selectedDay]
    ];
    return ListView.builder(
      itemCount: selectedEvents.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(selectedEvents[index].name),
          subtitle: Text(
            'Type: ${selectedEvents[index].isPositive ? 'Learn' : 'Unlearn'}\n'
            'Started: ${DateFormat.yMMMd().format(selectedEvents[index].startDate)}',
          ),
        );
      },
    );
  }
}
