part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserFound extends UserState {
  final String user;

  UserFound(this.user);

  @override
  List<Object> get props => [user];
}

class UserNotFound extends UserState {}
