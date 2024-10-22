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
    return Dismissible(
      key: Key(habit.id),
      direction: DismissDirection.horizontal,
      dismissThresholds: const {
        DismissDirection.startToEnd: 0.2,
        DismissDirection.endToStart: 0.2,
      },
      background: Container(
        color: Colors.red[100]?.withOpacity(0.5),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: const Icon(
          Icons.cancel_outlined,
          color: Colors.red,
        ),
      ),
      secondaryBackground: Container(
        color: Colors.green[100]?.withOpacity(0.5),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: const Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          final updatedCompletionStatus =
              List<bool>.from(habit.completionStatus);
          updatedCompletionStatus.add(true);
          final updatedHabit = Habit(
            id: habit.id,
            name: habit.name,
            startDate: habit.startDate,
            completionStatus: updatedCompletionStatus,
            isPositive: habit.isPositive,
            relapseCount: habit.relapseCount,
            relapseDate: habit.relapseDate,
            completionDate: DateTime.now(),
          );
          context.read<HabitBloc>().add(UpdateHabit(updatedHabit));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Habit completed')),
          );
          return false; // Prevent deletion
        } else if (direction == DismissDirection.startToEnd) {
          final updatedCompletionStatus =
              List<bool>.from(habit.completionStatus);
          updatedCompletionStatus.add(false);
          final updatedHabit = Habit(
            id: habit.id,
            name: habit.name,
            startDate: habit.startDate,
            completionStatus: updatedCompletionStatus,
            isPositive: habit.isPositive,
            relapseCount: habit.relapseCount,
            relapseDate: DateTime.now(),
            completionDate: habit.completionDate,
          );
          context.read<HabitBloc>().add(UpdateHabit(updatedHabit));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Habit relapsed')),
          );
          return false;
        }
        return false;
      },
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 2,
        child: ListTile(
          tileColor: habit.completionDate.day == DateTime.now().day
              ? Colors.green[100]?.withOpacity(0.5)
              : habit.relapseDate.day == DateTime.now().day
                  ? Colors.red[100]?.withOpacity(0.5)
                  : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditHabitScreen(habit: habit),
              ),
            );
          },
        ),
      ),
    );
  }
}
