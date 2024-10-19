import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bloc/habit_bloc.dart';
import 'bloc/navigation_bloc.dart'; // Importiere den Navigation BLoC
import 'bloc/habit_event.dart';
import 'repositories/habit_repository.dart';
import 'screens/habit_navigation_screen.dart'; // Importiere die BLoC-basierte Navigation
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

    return MultiBlocProvider(
      providers: [
        BlocProvider<HabitBloc>(
          create: (context) => HabitBloc(habitRepository)..add(LoadHabits()),
        ),
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Habit Tracker',
        initialRoute: '/',
        routes: {
          '/': (context) =>
              HabitNavigationScreen(), // Neue Startseite mit BLoC-Navigation
          '/add': (context) => AddHabitScreen(),
        },
      ),
    );
  }
}
