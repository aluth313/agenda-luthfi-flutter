part of 'upload_file_bloc.dart';

@immutable
abstract class UploadFileEvent {}

class IsChangeAttachment extends UploadFileEvent {
  final String path;

  IsChangeAttachment(this.path);
}

class UploadFileInit extends UploadFileEvent {}
