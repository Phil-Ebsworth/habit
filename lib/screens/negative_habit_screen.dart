import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/habit_bloc.dart';
import '../bloc/habit_event.dart';
import '../bloc/habit_state.dart';
import '../widgets/habit_tile.dart';

class NegativeHabitsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Negative Habits'),
      ),
      body: BlocBuilder<HabitBloc, HabitState>(
        builder: (context, state) {
          if (state is HabitsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HabitsLoaded) {
            // Nur negative Gewohnheiten anzeigen
            final negativeHabits =
                state.habits.where((habit) => !habit.isPositive).toList();
            return ListView.builder(
              itemCount: negativeHabits.length,
              itemBuilder: (context, index) {
                return HabitTile(habit: negativeHabits[index]);
              },
            );
          } else if (state is HabitsError) {
            return Center(child: Text('Failed to load habits.'));
          }
          return Container();
        },
      ),
    );
  }
}
