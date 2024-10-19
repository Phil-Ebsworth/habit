import 'package:bloc/bloc.dart';
import 'habit_event.dart';
import 'habit_state.dart';
import '../repositories/habit_repository.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final HabitRepository habitRepository;

  HabitBloc(this.habitRepository) : super(HabitsLoading()) {
    on<LoadHabits>((event, emit) async {
      emit(HabitsLoading());
      try {
        final habits = await habitRepository.getHabits();
        emit(HabitsLoaded(habits));
      } catch (_) {
        emit(HabitsError());
      }
    });

    on<AddHabit>((event, emit) async {
      try {
        await habitRepository.addHabit(event.habit);
        add(LoadHabits());
      } catch (_) {
        emit(HabitsError());
      }
    });

    on<UpdateHabit>((event, emit) async {
      try {
        await habitRepository.updateHabit(event.habit);
        add(LoadHabits());
      } catch (_) {
        emit(HabitsError());
      }
    });

    on<DeleteHabit>((event, emit) async {
      try {
        await habitRepository.deleteHabit(event.habitId);
        add(LoadHabits());
      } catch (_) {
        emit(HabitsError());
      }
    });
  }
}
