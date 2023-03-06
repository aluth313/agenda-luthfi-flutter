part of 'agenda_bloc.dart';

@immutable
abstract class AgendaState {}

class AgendaEmpty extends AgendaState {}

class AgendaLoading extends AgendaState {}

class AgendaError extends AgendaState {
  final String message;

  AgendaError(this.message);

  @override
  List<Object> get props => [message];
}

class AgendaHasData extends AgendaState {
  final List<Agenda> result;

  AgendaHasData(this.result);

  @override
  List<Object> get props => [result];
}
