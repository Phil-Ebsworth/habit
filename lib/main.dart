import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bloc/habit_bloc.dart';
import 'bloc/habit_event.dart';
import 'repositories/habit_repository.dart';
import 'screens/home_screen.dart';
import 'screens/add_habit_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HabitTrackerApp());
}

class HabitTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HabitRepository habitRepository = HabitRepository();

    return BlocProvider(
      create: (context) => HabitBloc(habitRepository)..add(LoadHabits()),
      child: MaterialApp(
        title: 'Habit Tracker',
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/add': (context) => AddHabitScreen(),
        },
      ),
    );
  }
}
