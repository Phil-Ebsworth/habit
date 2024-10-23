import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/screens/home_screen.dart';
import '../bloc/navigation_bloc.dart'; // Importiere den Navigation BLoC
import '../bloc/navigation_event.dart';
import '../bloc/navigation_state.dart';
import 'positive_habit_screen.dart';
import 'negative_habit_screen.dart';

class HabitNavigationScreen extends StatelessWidget {
  static final List<Widget> _widgetOptions = <Widget>[
    PositiveHabitsScreen(), // Bildschirm für positive Gewohnheiten
    NegativeHabitsScreen(),
    HomeScreenWithCalendar() // Bildschirm für negative Gewohnheiten
  ];

  const HabitNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          // Zeige den aktuell ausgewählten Bildschirm basierend auf dem Zustand
          return _widgetOptions.elementAt(state.selectedTabIndex);
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                    Icons.arrow_upward), // Symbol für positive Gewohnheiten
                label: 'Learn Habits',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                    Icons.arrow_downward), // Symbol für negative Gewohnheiten
                label: 'Unlearn Habits',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                    Icons.arrow_downward), // Symbol für negative Gewohnheiten
                label: 'kalendar',
              ),
            ],
            currentIndex: state.selectedTabIndex,
            selectedItemColor: Colors.blueAccent,
            onTap: (index) {
              // Event zum Wechseln der Registerkarte senden
              context.read<NavigationBloc>().add(SelectTabEvent(index));
            },
          );
        },
      ),
    );
  }
}
