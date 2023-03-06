part of 'reminder_bloc.dart';

@immutable
abstract class ReminderEvent {}

class IsChangeReminder extends ReminderEvent {
  final String reminder;

  IsChangeReminder(this.reminder);
}

class ReminderInit extends ReminderEvent {}
