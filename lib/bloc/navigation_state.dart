import 'package:equatable/equatable.dart';

class NavigationState extends Equatable {
  final int selectedTabIndex;

  const NavigationState({required this.selectedTabIndex});

  factory NavigationState.initial() {
    return NavigationState(
        selectedTabIndex:
            0); // Standardmäßig erste Registerkarte (Learn Habits)
  }

  NavigationState copyWith({int? selectedTabIndex}) {
    return NavigationState(
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
    );
  }

  @override
  List<Object> get props => [selectedTabIndex];
}
