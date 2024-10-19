import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState.initial()) {
    on<SelectTabEvent>((event, emit) {
      emit(state.copyWith(selectedTabIndex: event.selectedTabIndex));
    });
  }
}
