import 'package:flutter/material.dart';
import '../models/habit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/habit_bloc.dart';
import '../bloc/habit_event.dart';
import 'package:intl/intl.dart'; // Für die Formatierung des Datums

class HabitTile extends StatelessWidget {
  final Habit habit;

  HabitTile({required this.habit});

  // Methode zur Berechnung der verstrichenen Zeit
  String calculateTimeSinceStart(DateTime startDate) {
    final Duration difference = DateTime.now().difference(startDate);

    if (difference.inDays >= 30) {
      final int months = (difference.inDays / 30).floor();
      return '$months month(s) ago';
    } else if (difference.inDays >= 7) {
      final int weeks = (difference.inDays / 7).floor();
      return '$weeks week(s) ago';
    } else {
      return '${difference.inDays} day(s) ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(habit.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Started: ${DateFormat.yMMMd().format(habit.startDate)}'),
          Text(
              'Elapsed time: ${calculateTimeSinceStart(habit.startDate)}'), // Verstrichene Zeit anzeigen
          Text(
              'Relapses: ${habit.relapseCount}'), // Anzahl der Rückfälle anzeigen
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Reset-Button: Startdatum auf aktuelles Datum setzen
              final updatedHabit = Habit(
                id: habit.id,
                name: habit.name,
                startDate: DateTime.now(),
                completionStatus: habit.completionStatus,
                relapseCount:
                    habit.relapseCount, // Rückfälle bleiben unverändert
              );
              context.read<HabitBloc>().add(UpdateHabit(updatedHabit));
            },
          ),
          IconButton(
            icon: Icon(Icons.replay),
            onPressed: () {
              // Rückfall-Button: Rückfälle um 1 erhöhen und Startdatum auf aktuelles Datum setzen
              final updatedHabit = Habit(
                id: habit.id,
                name: habit.name,
                startDate: DateTime.now(),
                completionStatus: habit.completionStatus,
                relapseCount: habit.relapseCount + 1, // Rückfälle um 1 erhöhen
              );
              context.read<HabitBloc>().add(UpdateHabit(updatedHabit));
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              context.read<HabitBloc>().add(DeleteHabit(habit.id));
            },
          ),
        ],
      ),
    );
  }
}
