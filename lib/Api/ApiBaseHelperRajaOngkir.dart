import 'dart:convert';
import 'dart:io';

import 'package:apps/Utils/appException.dart';
import 'package:http/http.dart' as http;

class ApiBaseHelperRajaOngkir {
//  final _baseUrl = 'm-bangun.com';
  final _baseUrl = 'pro.rajaongkir.com';

//  final _path = 'api-v2/';
  final _path = 'api/';

  Future<dynamic> get(String url, param) async {
    var responseJson;
    try {
      final _url = Uri.https(_baseUrl, _path + url, param);
      print(_url);
      var header = {'key': "e99ff50191d54f9bc76c9c00e43cd158"};
      final response = await http.get(_url, headers: header);
      responseJson = _returnResponse(response);
    } on SocketException catch (err) {
      return AppException(err.osError.errorCode, err.message);
    }
    return responseJson;
  }

  Future<dynamic> post(String url, body) async {
    var responseJson;
    try {
      final _url = Uri.https(_baseUrl, _path + url);
      final response = await http.post(_url, body: body);
      responseJson = _returnResponse(response);
    } on SocketException catch (err) {
      return FetchDataException(err.osError.errorCode.toString());
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
