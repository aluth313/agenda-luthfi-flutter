part of 'reminder_bloc.dart';

@immutable
abstract class ReminderState {}

class ReminderInitial extends ReminderState {}

class ReminderChanged extends ReminderState {
  final String reminder;

  ReminderChanged(this.reminder);

  @override
  List<Object> get props => [reminder];
}
