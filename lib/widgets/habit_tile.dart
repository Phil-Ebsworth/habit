import 'package:flutter/material.dart';
import '../models/habit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/habit_bloc.dart';
import '../bloc/habit_event.dart';

class HabitTile extends StatelessWidget {
  final Habit habit;

  const HabitTile({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(habit.name),
      subtitle: Text('Started: ${habit.startDate.toString()}'),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          context.read<HabitBloc>().add(DeleteHabit(habit.id));
        },
      ),
    );
  }
}
