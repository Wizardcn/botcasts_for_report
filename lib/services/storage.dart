import 'package:botcasts/utils/credentials.dart';
import 'package:simple_s3/simple_s3.dart';

class S3StorageService {
  final SimpleS3 _simpleS3 = SimpleS3();

  Future<String?> upload_user_profile_pict(file) async {
    String? result;

    if (result == null) {
      try {
        result = await _simpleS3.uploadFile(
          file,
          Credentials.s3_bucketName,
          Credentials.s3_poolD,
          AWSRegions.apSouthEast1,
          debugLog: true,
          s3FolderPath: "botcasts/users/profile_pics",
          accessControl: S3AccessControl.publicReadWrite,
          useTimeStamp: true,
        );
      } catch (e) {
        // ignore: avoid_print
        print(e.toString());
      }
    }
    return result;
  }
}
