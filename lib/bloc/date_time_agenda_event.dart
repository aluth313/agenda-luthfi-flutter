part of 'date_time_agenda_bloc.dart';

@immutable
abstract class DateTimeAgendaEvent {}

class IsChange extends DateTimeAgendaEvent {
  final DateTime dateTime;

  IsChange(this.dateTime);
}

class DateTimeInit extends DateTimeAgendaEvent {}
