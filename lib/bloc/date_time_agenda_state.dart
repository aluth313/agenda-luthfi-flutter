part of 'date_time_agenda_bloc.dart';

@immutable
abstract class DateTimeAgendaState {}

class DateTimeAgendaInitial extends DateTimeAgendaState {}

class DateTimeAgendaChanged extends DateTimeAgendaState {
  final DateTime dateTime;

  DateTimeAgendaChanged(this.dateTime);

  @override
  List<Object> get props => [dateTime];
}
