import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'upload_file_event.dart';
part 'upload_file_state.dart';

class UploadFileBloc extends Bloc<UploadFileEvent, UploadFileState> {
  UploadFileBloc() : super(UploadFileInitial()) {
    on<IsChangeAttachment>((event, emit) {
      final path = event.path;
      emit(UploadFileChanged(path));
    });

    on<UploadFileInit>((event, emit) {
      emit(UploadFileInitial());
    });
  }
}
