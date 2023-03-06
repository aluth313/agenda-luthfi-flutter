part of 'gender_bloc.dart';

@immutable
abstract class GenderEvent {}

class IsChangeGender extends GenderEvent {
  final String gender;

  IsChangeGender(this.gender);
}
