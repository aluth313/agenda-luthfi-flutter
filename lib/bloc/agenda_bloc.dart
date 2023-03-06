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
  }
}
