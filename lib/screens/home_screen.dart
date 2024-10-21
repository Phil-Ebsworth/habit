import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/habit_bloc.dart'; // blocs -> bloc
import '../bloc/habit_event.dart'; // blocs -> bloc
import '../bloc/habit_state.dart'; // blocs -> bloc
import '../widgets/habit_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracker'),
      ),
      body: BlocBuilder<HabitBloc, HabitState>(
        builder: (context, state) {
          if (state is HabitsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HabitsLoaded) {
            return ListView.builder(
              itemCount: state.habits.length,
              itemBuilder: (context, index) {
                return HabitTile(habit: state.habits[index]);
              },
            );
          } else if (state is HabitsError) {
            return const Center(child: Text('Failed to load habits.'));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
