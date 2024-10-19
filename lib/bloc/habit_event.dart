import 'package:equatable/equatable.dart';
import '../models/habit.dart';

abstract class HabitEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadHabits extends HabitEvent {}

class AddHabit extends HabitEvent {
  final Habit habit;
  AddHabit(this.habit);

  @override
  List<Object?> get props => [habit];
}

class UpdateHabit extends HabitEvent {
  final Habit habit;
  UpdateHabit(this.habit);

  @override
  List<Object?> get props => [habit];
}

class DeleteHabit extends HabitEvent {
  final String habitId;
  DeleteHabit(this.habitId);

  @override
  List<Object?> get props => [habitId];
}

// Neues Event für dynamische Updates
class UpdateHabits extends HabitEvent {
  final List<Habit> habits;
  UpdateHabits(this.habits);

  @override
  List<Object?> get props => [habits];
}
