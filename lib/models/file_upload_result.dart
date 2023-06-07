// To parse this JSON data, do
//
//     final fileUploadResult = fileUploadResultFromJson(jsonString);

import 'dart:convert';

FileUploadResult fileUploadResultFromJson(String str) =>
    FileUploadResult.fromJson(json.decode(str));

String fileUploadResultToJson(FileUploadResult data) =>
    json.encode(data.toJson());

class FileUploadResult {
  FileUploadResult({
    this.fileName,
    this.urlPhoto,
  });

  String? fileName;
  String? urlPhoto;

  factory FileUploadResult.fromJson(Map<String, dynamic> json) =>
      FileUploadResult(
        fileName: json["fileName"],
        urlPhoto: json["urlPhoto"],
      );

  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "urlPhoto": urlPhoto,
      };
}
