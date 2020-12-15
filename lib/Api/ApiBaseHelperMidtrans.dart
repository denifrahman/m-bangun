import 'dart:convert';
import 'dart:io';

import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/appException.dart';
import 'package:http/http.dart' as http;

class ApiBaseHelperMidtrans {
  final _baseUrl = apiBaseUrlMidtransProd;
  final _baseUrlStatus = apiBaseUrlMidtransStatusProd;
  final _path = 'snap/v1/';
  final _pathStatus = 'v2/';
  final header = {
    'Authorization': "Basic TWlkLXNlcnZlci1BRm5oenFPWlZaY2hQSVB5TkYzQ29xcUM6bV9CYW5ndW4yMDIw",
    "Accept": "application/json",
    "content-type": "application/json",
  };

//
//  final header = {
//    'Authorization': "Basic U0ItTWlkLXNlcnZlci13VmVqa09Cb3NZZmJTUGtwVXhQUVZ5Skw6bV9CYW5ndW4yMDIw",
//    "Accept": "application/json",
//    "content-type": "application/json",
//  };
  Future<dynamic> get(String url, param) async {
    var responseJson;
    try {
      final _url = Uri.https(_baseUrl, _path + url, param);
//      var header = {'Authorization': "Basic TWlkLXNlcnZlci1BRm5oenFPWlZaY2hQSVB5TkYzQ29xcUM6bV9CYW5ndW4yMDIw"};
      final response = await http.get(_url, headers: header);
      responseJson = _returnResponse(response);
    } on SocketException catch (err) {
      return 'Conncetion Error';
    }
    return responseJson;
  }

  Future<dynamic> getStatus(String url) async {
    var responseJson;
    try {
//      final _url = Uri.https(_baseUrl, _path + url);
      final _url = Uri.https(_baseUrlStatus, _pathStatus + url);
//      var header = {'Authorization': "Basic TWlkLXNlcnZlci1BRm5oenFPWlZaY2hQSVB5TkYzQ29xcUM6bV9CYW5ndW4yMDIw", "Accept": "application/json", "content-type": "application/json"};
      final response = await http.get(_url, headers: header);
//      print(response.statusCode);
      responseJson = _returnResponse(response);
    } on SocketException catch (err) {
      return 'Conncetion Error';
    }
    return responseJson;
  }

  Future<dynamic> post(String url, body) async {
    var responseJson;
    try {
      final _url = Uri.https(_baseUrl, _path + url);
      final response = await http.post(_url, body: body, headers: header);
      // print(response.body);
      responseJson = _returnResponse(response);
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
      case 201:
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
