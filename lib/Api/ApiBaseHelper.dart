import 'dart:convert';
import 'dart:io';

import 'package:apps/Utils/appException.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ApiBaseHelper {
  final _baseUrl = 'm-bangun.com';

//  final _baseUrl = '192.168.100.248';

  final _path = 'api-v2/';

//  final _path = 'api-mbangun/';

  Future<dynamic> get(String url, param) async {
    var responseJson;
    try {
      final _url = Uri.http(_baseUrl, _path + url, param);
      print(_url);
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
      return FetchDataException(err.osError.errorCode.toString());
    }
    return responseJson;
  }

  Future<dynamic> multipart(String url, files, body) async {
    var responseJson;
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
      request.fields['id'] = body['id'];
      request.fields['nama'] = body['nama'];
      request.fields['berat'] = body['berat'];
      request.fields['foto'] = body['foto'];
      request.fields['foto1'] = body['foto1'];
      request.fields['foto2'] = body['foto2'];
      request.fields['jenis_ongkir'] = body['jenis_ongkir'];
      request.fields['deskripsi'] = body['deskripsi'];
      request.fields['id_kategori'] = body['id_kategori'];
      request.fields['id_toko'] = body['id_toko'];
      request.fields['kondisi'] = body['kondisi'];
      request.fields['minimal_pesanan'] = body['minimal_pesanan'];
      request.fields['harga'] = body['harga'];
      request.fields['stok'] = body['stok'];
      var response = await request.send();

      final result = await http.Response.fromStream(response);
      print(result.body);
      if (result.statusCode == 200) {
        responseJson = _returnResponse(result);
      } else {
        responseJson = result.statusCode.toString();
      }
    } on SocketException catch (err) {
      print(err.osError);
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
