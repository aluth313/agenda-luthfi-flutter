part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class CheckUser extends UserEvent {
  final String email;
  final String password;

  CheckUser(this.email, this.password);
}

class UserInit extends UserEvent {}
