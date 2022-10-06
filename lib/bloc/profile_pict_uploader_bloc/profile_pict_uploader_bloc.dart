import 'package:bloc/bloc.dart';
import 'package:botcasts/services/database.dart';
import 'package:botcasts/services/storage.dart';
import 'package:botcasts/utils/change_file_name.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';
part 'profile_pict_uploader_event.dart';
part 'profile_pict_uploader_state.dart';

class ProfilePictUploaderBloc
    extends Bloc<ProfilePictUploaderEvent, ProfilePictUploaderState> {
  ProfilePictUploaderBloc() : super(ProfilePictUploaderInitial()) {
    on<ProfilePictUploaderPressed>((event, emit) async {
      emit(ProfilePictUploaderLoading());
      try {
        File filepath =
            await changeFileNameOnly(File(event.fileName), "${event.uid}.jpg");
        String? profilePictUrl =
            await S3StorageService().upload_user_profile_pict(filepath);
        emit(UploadToS3Finished());
        await DatabaseService(uid: event.uid).updateUserDetail(
          event.username,
          event.email,
          profilePictUrl,
        );
        emit(UploadToDBFinished());
      } catch (e) {
        emit(ProfilePictUploaderError(e.toString()));
      }
    });

    on<ResetProfilePictUploader>((event, emit) {
      emit(ProfilePictUploaderInitial());
    });
  }
}
