part of 'agenda_bloc.dart';

@immutable
abstract class AgendaEvent {}

class FetchAgendas extends AgendaEvent {}

class AddAgenda extends AgendaEvent {
  final String title;
  final String description;
  final String dateTime;
  final String attachment;
  final String? remider;

  AddAgenda(
    this.title,
    this.description,
    this.dateTime,
    this.attachment,
    this.remider,
  );
}

class DeleteAgenda extends AgendaEvent {
  final int id;

  DeleteAgenda(
    this.id,
  );
}
