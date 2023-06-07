import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../services/api_services.dart';
import '../models/file_upload_result.dart';

class FileUploadService {
  Future<FileUploadResult> uploadFile(File image) async {
    Map<String, String> headers = {
      'accept': 'application/json',
      'Content-Type': 'multipart/form-data'
    };
    var request = http.MultipartRequest('POST', urlPostArchives);

    request.headers.addAll(headers);
    request.fields['file'] = "file";
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    //print('respuesta de imagen:${response.body}');

    if (response.statusCode == 200) {
      return FileUploadResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post file');
    }
  }
}
