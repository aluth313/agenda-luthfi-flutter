part of 'gender_bloc.dart';

@immutable
abstract class GenderState {}

class GenderInitial extends GenderState {}

class GenderChanged extends GenderState {
  final String gender;

  GenderChanged(this.gender);

  @override
  List<Object> get props => [gender];
}
