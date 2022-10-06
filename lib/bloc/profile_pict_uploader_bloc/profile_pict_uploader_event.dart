part of 'profile_pict_uploader_bloc.dart';

abstract class ProfilePictUploaderEvent extends Equatable {
  const ProfilePictUploaderEvent();

  @override
  List<Object> get props => [];
}

class ProfilePictUploaderPressed extends ProfilePictUploaderEvent {
  final String uid;
  final String username;
  final String email;
  final String fileName;

  const ProfilePictUploaderPressed({
    required this.uid,
    required this.username,
    required this.email,
    required this.fileName,
  });
}

class ResetProfilePictUploader extends ProfilePictUploaderEvent {}
