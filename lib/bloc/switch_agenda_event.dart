part of 'switch_agenda_bloc.dart';

@immutable
abstract class SwitchAgendaEvent {}

class IsActivate extends SwitchAgendaEvent {
  final bool isActive;

  IsActivate(this.isActive);
}
