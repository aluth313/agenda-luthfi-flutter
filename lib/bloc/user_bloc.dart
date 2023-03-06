import 'package:agenda_luthfi/data/db/database_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  DatabaseHelper _dbHelper;

  UserBloc(this._dbHelper) : super(UserInitial()) {
    on<CheckUser>((event, emit) async {
      final email = event.email;
      final password = event.password;

      emit(UserLoading());
      final checkUser = await _dbHelper.getUserByEmailPassword(email, password);
      checkUser.isNotEmpty ? emit(UserFound()) : emit(UserNotFound());
    });

    on<UserInit>((event, emit) async {
      emit(UserInitial());
    });
  }
}
