import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/appException.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ApiBaseHelper {
//  final _baseUrl = 'm-bangun.com';
  final _baseUrl = apiBaseURL;
  final _path = pathBaseUrl;

  Future<dynamic> get(String url, param) async {
    var responseJson;
    try {
      final _url = Uri.https(_baseUrl, _path + url, param);
      final response = await http.get(_url);
      print(_url);
      print(response.body);
      responseJson = _returnResponse(response);
    } on SocketException {
      return 'Conncetion Error';
    }

    return responseJson;
  }

  Future<dynamic> post(String url, body) async {
    var responseJson;
    try {
      final _url = Uri.https(_baseUrl, _path + url);
      var header = {"Content-Type": "application/json"};
      final response = await http.post(_url, body: body);
      print(response.body);
      responseJson = _returnResponse(response);
    } on SocketException catch (err) {
      return 'Conncetion Error';
    }
    return responseJson;
  }

  Future<dynamic> multipart(String url, files, body) async {
    var responseJson;
    try {
      final _url = Uri.https(_baseUrl, _path + url);
      var request = new http.MultipartRequest("POST", _url);
      for (var file in files) {
        if (file != null) {
          final mimeTypeprodukthumbnail = lookupMimeType(file.path, headerBytes: [0xFF, 0xD8]).split('/');
          print(mimeTypeprodukthumbnail);
          final foto = await http.MultipartFile.fromPath('foto[]', file.path, contentType: MediaType(mimeTypeprodukthumbnail[0], mimeTypeprodukthumbnail[1]));
          request.files.addAll([foto]);
        }
      }
      request.fields.addAll(body);
      var response = await request.send();
      final result = await http.Response.fromStream(response);
      // print(result.body);
      if (result.statusCode == 200) {
        responseJson = _returnResponse(result);
      } else {
        responseJson = result.statusCode.toString();
      }
    } on SocketException catch (err) {
      return 'Conncetion Error';
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
