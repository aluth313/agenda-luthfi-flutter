import 'package:agenda_luthfi/data/db/database_helper.dart';
import 'package:agenda_luthfi/data/models/agenda_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'agenda_event.dart';
part 'agenda_state.dart';

class AgendaBloc extends Bloc<AgendaEvent, AgendaState> {
  DatabaseHelper _dbHelper;

  AgendaBloc(this._dbHelper) : super(AgendaEmpty()) {
    on<FetchAgendas>((event, emit) async {
      emit(AgendaLoading());
      try {
        final agendas = await _dbHelper.getAgendas();
        agendas.isNotEmpty ? emit(AgendaHasData(agendas)) : emit(AgendaEmpty());
      } catch (e) {
        emit(AgendaError(e.toString()));
      }
    });

    on<AddAgenda>((event, emit) async {
      final String title = event.title;
      final String description = event.description;
      final String dateTime = event.dateTime;
      final String attachment = event.attachment;
      final String? remider = event.remider;

      emit(AgendaLoading());
      try {
        final agendas = await _dbHelper.insertAgenda(Agenda(
          title: title,
          description: description,
          datetime: dateTime,
          attachment: attachment,
        ));
        emit(AgendaSuccessAdded());
      } catch (e) {
        emit(AgendaFailedAdded(e.toString()));
      }
    });

    on<DeleteAgenda>((event, emit) async {
      final int id = event.id;

      emit(AgendaLoading());
      try {
        final remove = await _dbHelper.removeAgenda(id);
        emit(AgendaSuccessRemoved());
        final agendas = await _dbHelper.getAgendas();
        agendas.isNotEmpty ? emit(AgendaHasData(agendas)) : emit(AgendaEmpty());
      } catch (e) {
        emit(AgendaFailedAdded(e.toString()));
      }
    });
  }
}
