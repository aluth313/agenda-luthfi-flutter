import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'switch_agenda_event.dart';
part 'switch_agenda_state.dart';

class SwitchAgendaBloc extends Bloc<SwitchAgendaEvent, SwitchAgendaState> {
  SwitchAgendaBloc() : super(IsNotActive()) {
    on<IsActivate>((event, emit) {
      final isActive = event.isActive;
      emit(isActive ? IsActive() : IsNotActive());
    });
  }
}
