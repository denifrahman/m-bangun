import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

const baseUrl = "http://niagatravel.com/api/api-m-bangun-jwt-token/api/";
//const baseUrl = "http://192.168.0.6:8888/api_jwt/api/";

class Api {
  static Future getToken() {
    var map = new Map<String, dynamic>();
    map['useremail'] = 'denifrahman@gmail.com';
    map['userpassword'] = '123';
    var url = baseUrl + "users/login";
    return http.post(url, body: map);
  }

  static Future uploadImage(File image, userid) async {
    final mimeTypeData =
        lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
    // Intilize the multipart request
    final imageUploadRequest =
        http.MultipartRequest('POST', Uri.parse(baseUrl + '/Users/editFoto'));
    final file = await http.MultipartFile.fromPath('image', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    imageUploadRequest.fields['ext'] = mimeTypeData[1];
    imageUploadRequest.fields['userid'] = userid;
    imageUploadRequest.files.add(file);
    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200) {
        return response;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future updateAkun(File _imageFileSiup, File _imageFileAkte, idKategori,
      idSubKategori, namaPerusahaan, userId) async {
    if (_imageFileSiup != null && _imageFileAkte != null) {
      final mimeTypeData1 =
          lookupMimeType(_imageFileSiup.path, headerBytes: [0xFF, 0xD8])
              .split('/');
      final mimeTypeData2 =
          lookupMimeType(_imageFileAkte.path, headerBytes: [0xFF, 0xD8])
              .split('/');
      // Intilize the multipart request
      final imageUploadRequest = http.MultipartRequest(
          'POST', Uri.parse(baseUrl + '/Users/updateAkunPremium'));
      final fileSiup = await http.MultipartFile.fromPath(
          'imageFileSiup', _imageFileSiup.path,
          contentType: MediaType(mimeTypeData1[0], mimeTypeData1[1]));
      final fileAkte = await http.MultipartFile.fromPath(
          'imageFileAkte', _imageFileAkte.path,
          contentType: MediaType(mimeTypeData2[0], mimeTypeData2[1]));
      imageUploadRequest.fields['ext'] = mimeTypeData1[1];
      imageUploadRequest.fields['userPerusahaan'] = namaPerusahaan;
      imageUploadRequest.fields['idSubKategori'] = idSubKategori;
      imageUploadRequest.fields['idKategori'] = idKategori;
      imageUploadRequest.fields['userId'] = userId;
      imageUploadRequest.files.add(fileSiup);
      imageUploadRequest.files.add(fileAkte);
      try {
        final streamedResponse = await imageUploadRequest.send();
        final response = await http.Response.fromStream(streamedResponse);
        if (response.statusCode != 200) {
          return response;
        }
      } catch (e) {
        print(e);
        return null;
      }
    } else {
      // Intilize the multipart request
      final imageUploadRequest = http.MultipartRequest(
          'POST', Uri.parse(baseUrl + '/Users/updateAkunPremium'));
      imageUploadRequest.fields['userPerusahaan'] = namaPerusahaan;
      imageUploadRequest.fields['idSubKategori'] = idSubKategori;
      imageUploadRequest.fields['idKategori'] = idKategori;
      imageUploadRequest.fields['userId'] = userId;
      try {
        final streamedResponse = await imageUploadRequest.send();
        final response = await http.Response.fromStream(streamedResponse);
        if (response.statusCode != 200) {
          return response;
        }
      } catch (e) {
        print(e);
        return null;
      }
    }
  }

  static Future register(body) {
    var url = baseUrl + "Users/register";
    return http.post(url, body: body);
  }

  static Future login(body) {
    var url = baseUrl + "Users/login";
    return http.post(url, body: body);
  }

  static Future getKategori(token) {
    var url = baseUrl + "kategori/getAll";
    return http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }

  static Future getAllByFilterParam(token, akses) {
    var url = baseUrl + "kategori/getAllByFilterParam?akses=" + akses;
    return http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }

  static Future getUserById(token, userid) {
    var url = baseUrl + "Users/getById?userid=" + userid;
    return http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }

  static Future getAllSubKategoriByIdKategori(token, idKategori) {
    var url = baseUrl + "SubKategori/getAllByIdKategori/" + idKategori;
    print(url);
    return http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }

  static Future getAllProvinsi(token) {
    var url = baseUrl + "Provinsi/getAll";
    return http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }

  static Future getProvinsiById(token, idProvinsi) {
    var url = baseUrl + "Provinsi/getById/" + idProvinsi;
    return http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }

  static Future getAllKotaByIdProvinsi(token, idProvinsi) {
    var url = baseUrl + "kota/getAllByIdProvinsi/" + idProvinsi;
    return http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }

  static Future getKotaById(token, idKota) {
    var url = baseUrl + "kota/getById/" + idKota;
    return http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }

  static Future getAllKecamatanByIdKota(token, idKota) {
    var url = baseUrl + "kecamatan/getAllByIdKota/" + idKota;
    return http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }

  static Future getKecamatanById(token, idKota) {
    var url = baseUrl + "kecamatan/getById/" + idKota;
    return http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }

  static Future getAllNews(token) {
    var url = baseUrl + "news/getAll";
    return http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }

  static Future getAllProdukByParam(token, idKecamatan, idKota, idProvinsi,
      idSubKategori, Key) {
    var sub = (idSubKategori == '' ? '' : 'sub=' + idSubKategori);
    var kec = (idKecamatan == '' ? '' : '&kec=' + idKecamatan);
    var kota = (idKota == '' ? '' : '&kota=' + idKota);
    var prov = (idProvinsi == '' ? '' : '&prov=' + idProvinsi);
    var key = (Key == '' ? '' : '&key=' + Key);
    var url = baseUrl + "produk/getAllByParam?" + sub + kec + kota + prov + key;
    print(url);
    return http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }
}
