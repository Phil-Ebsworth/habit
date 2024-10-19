import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SelectTabEvent extends NavigationEvent {
  final int selectedTabIndex;

  SelectTabEvent(this.selectedTabIndex);

  @override
  List<Object> get props => [selectedTabIndex];
}
