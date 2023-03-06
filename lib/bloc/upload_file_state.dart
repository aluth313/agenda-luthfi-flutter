part of 'upload_file_bloc.dart';

@immutable
abstract class UploadFileState {}

class UploadFileInitial extends UploadFileState {}

class UploadFileChanged extends UploadFileState {
  final String path;

  UploadFileChanged(this.path);

  @override
  List<Object> get props => [path];
}
