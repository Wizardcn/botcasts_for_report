part of 'profile_pict_uploader_bloc.dart';

abstract class ProfilePictUploaderState extends Equatable {
  const ProfilePictUploaderState();

  @override
  List<Object> get props => [];
}

class ProfilePictUploaderInitial extends ProfilePictUploaderState {}

class ProfilePictUploaderLoading extends ProfilePictUploaderState {}

class UploadToS3Finished extends ProfilePictUploaderState {}

class UploadToDBFinished extends ProfilePictUploaderState {}

class ProfilePictUploaderError extends ProfilePictUploaderState {
  final String message;

  const ProfilePictUploaderError(this.message);
}
