import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reminder_event.dart';
part 'reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  ReminderBloc() : super(ReminderInitial()) {
    on<IsChangeReminder>((event, emit) {
      final reminder = event.reminder;
      emit(ReminderChanged(reminder));
    });

    on<ReminderInit>((event, emit) {
      emit(ReminderInitial());
    });
  }
}
