import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:apps/Utils/appException.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ApiBaseHelper {
  final _baseUrl = 'm-bangun.com';

//  final _baseUrl = '192.168.0.6';

  final _path = 'api-v2/';

//  final _path = 'api-mbangun/';

  Future<dynamic> get(String url, param) async {
    var responseJson;
    try {
      final _url = Uri.http(_baseUrl, _path + url, param);
      final response = await http.get(_url);
      responseJson = _returnResponse(response);
    } on SocketException catch (err) {
      return AppException(err.osError.errorCode, err.message);
    }
    return responseJson;
  }

  Future<dynamic> post(String url, body) async {
    var responseJson;
    try {
      final _url = Uri.http(_baseUrl, _path + url);
      var header = {"Content-Type": "application/json"};
      final response = await http.post(_url, body: body);
      responseJson = _returnResponse(response);
    } on SocketException catch (err) {
      print(err.osError);
      return AppException(err.osError.errorCode, err.message);
    }
    return responseJson;
  }

  Future<dynamic> multipart(String url, files, body) async {
    var responseJson;
    var client = new http.Client();
    try {
      final _url = Uri.http(_baseUrl, _path + url);
      var request = new http.MultipartRequest("POST", _url);
      for (var file in files) {
        if (file != null) {
          final mimeTypeprodukthumbnail = lookupMimeType(file.path, headerBytes: [0xFF, 0xD8]).split('/');
          final foto = await http.MultipartFile.fromPath('foto[]', file.path, contentType: MediaType(mimeTypeprodukthumbnail[0], mimeTypeprodukthumbnail[1]));
          request.files.addAll([foto]);
        }
      }
      request.fields.addAll(body);
      int byteCount = 0;
      print('${request.fields.values.toString()}' + 'test');
      var response = await request.send();
      final result = await http.Response.fromStream(response);

      if (result.statusCode == 200) {
        responseJson = _returnResponse(result);
      } else {
        responseJson = result.statusCode.toString();
      }
    } on SocketException catch (err) {
      return AppException(err.osError.errorCode, err.message);
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        return FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
