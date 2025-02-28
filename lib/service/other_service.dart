import 'dart:io';

import 'package:restaures/components/Global/api_constants.dart';
import 'package:restaures/components/Global/api_response.dart';
import 'package:restaures/utils/api_service.dart';

class OtherService {
  static final ApiService _apiService = ApiService();

  static Future<ApiResponse> uploadImage(
      {List<File> file = const [],
      List<File> files = const [],
      String contentType = 'image/jpeg',
      String? filePath,
      String? metaData,
      String? fileName}) async {
    Map<String, String> fields = {
      'filePath': filePath ?? '',
      'metadata': metaData ?? '',
      'fileName': fileName ?? '',
      'contentType': contentType,
    };

    Map<String, List<File>> ufiles = {
      'file': file,
      'files': files,
    };

    return await _apiService.postMultipart(ApiUrl.uploadFile, fields, ufiles);
  }
}
