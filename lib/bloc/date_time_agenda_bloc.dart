import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'date_time_agenda_event.dart';
part 'date_time_agenda_state.dart';

class DateTimeAgendaBloc
    extends Bloc<DateTimeAgendaEvent, DateTimeAgendaState> {
  DateTimeAgendaBloc() : super(DateTimeAgendaInitial()) {
    on<IsChange>((event, emit) {
      final dateTime = event.dateTime;
      emit(DateTimeAgendaChanged(dateTime));
    });

    on<DateTimeInit>((event, emit) {
      emit(DateTimeAgendaInitial());
    });
  }
}
