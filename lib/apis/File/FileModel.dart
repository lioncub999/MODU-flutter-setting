import 'package:modu_flutter/apis/ApiResponse.dart';

class FileModel extends ApiResponse {

  String? serviceTp;
  String? fileName;
  int? fileSize;
  int? fileSeq;
  String? presignedUrl;
  String? fileId;
  String? fileExt;

  Map<String, dynamic> toJson() => {
    'serviceTp' :serviceTp,
    'fileName' : fileName,
    'fileSize' : fileSize,
    'fileSeq' : fileSeq,
    'fileId' : fileId,
    'presignedUrl' : presignedUrl,
    'fileExt' : fileExt,
  };
}