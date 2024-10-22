import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/habit_bloc.dart';
import '../bloc/habit_event.dart';
import '../bloc/habit_state.dart';
import '../widgets/habit_tile.dart';

class NegativeHabitsScreen extends StatelessWidget {
  const NegativeHabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bad Habits'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add');
            },
          ),
        ],
      ),
      body: BlocBuilder<HabitBloc, HabitState>(
        builder: (context, state) {
          if (state is HabitsLoading) {
            return const Center(child: CircularProgressIndicator());
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
            return const Center(child: Text('Failed to load habits.'));
          }
          return Container();
        },
      ),
    );
  }
}
