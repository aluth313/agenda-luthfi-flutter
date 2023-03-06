import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'gender_event.dart';
part 'gender_state.dart';

class GenderBloc extends Bloc<GenderEvent, GenderState> {
  GenderBloc() : super(GenderInitial()) {
    on<IsChangeGender>((event, emit) {
      final gender = event.gender;
      emit(GenderChanged(gender));
    });
  }
}
