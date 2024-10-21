import 'package:flutter/material.dart';
import '../models/habit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/habit_bloc.dart';
import '../bloc/habit_event.dart';
import 'package:intl/intl.dart';
import '../screens/edit_habit_screen.dart';

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
          Text('Type: ${habit.isPositive ? 'Learn' : 'Unlearn'}'),
          Text('Started: ${DateFormat.yMMMd().format(habit.startDate)}'),
          Text('Elapsed time: ${calculateTimeSinceStart(habit.startDate)}'),
          Text('Relapses: ${habit.relapseCount}'),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Erledigt-Button: Markiert das Habit für den Tag als abgeschlossen
          IconButton(
            icon: Icon(Icons.check_circle, color: Colors.green),
            onPressed: () {
              final updatedCompletionStatus =
                  List<bool>.from(habit.completionStatus);
              updatedCompletionStatus
                  .add(true); // Füge einen "erledigt"-Tag hinzu

              final updatedHabit = Habit(
                id: habit.id,
                name: habit.name,
                startDate: habit.startDate,
                completionStatus: updatedCompletionStatus,
                isPositive: habit.isPositive,
                relapseCount: habit.relapseCount,
              );
              context.read<HabitBloc>().add(UpdateHabit(updatedHabit));
            },
          ),
          // Rückfall-Button: Erhöht die Rückfallanzahl
          IconButton(
            icon: Icon(Icons.replay, color: Colors.red),
            onPressed: () {
              final updatedHabit = Habit(
                id: habit.id,
                name: habit.name,
                startDate: habit.startDate,
                completionStatus: habit.completionStatus,
                isPositive: habit.isPositive,
                relapseCount:
                    habit.relapseCount + 1, // Erhöht die Rückfälle um 1
              );
              context.read<HabitBloc>().add(UpdateHabit(updatedHabit));
            },
          ),
          // Löschen-Button: Löscht das Habit
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              context.read<HabitBloc>().add(DeleteHabit(habit.id));
            },
          ),
        ],
      ),
      onTap: () {
        // Beim Klicken auf das Habit zur Bearbeitungsseite navigieren
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditHabitScreen(habit: habit),
          ),
        );
      },
    );
  }
}
