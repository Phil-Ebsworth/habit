import 'package:equatable/equatable.dart';
import '../models/habit.dart';

abstract class HabitState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HabitsLoading extends HabitState {}

class HabitsLoaded extends HabitState {
  final List<Habit> habits;
  HabitsLoaded(this.habits);

  @override
  List<Object?> get props => [habits];
}

class HabitsError extends HabitState {}
