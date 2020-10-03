import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:apps/Utils/SettingApp.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

//const baseUrl = "http://niagatravel.com/api/api-m-bangun-jwt-token/api/";
const baseUrl = "https://mbangun.id/api-v2/";
//const baseUrl = "http://192.168.0.6/api_jwt/api/";
//const baseUrl = "http://192.168.0.6/api_jwt/api/";
//const api_url = "192.168.0.6";
//const param = '/api_jwt/api/';
const param = '/wp-json/wc/v3/';
const wp = '/wp-json/wp/v2/';
const wc = '/wp-json/wc/v3/';
const api_url = "m-bangun.com";
String basicAuth = 'Basic ' + base64Encode(utf8.encode('${'m-bangun'}:${'admin9876'}'));

class Api {
  static Future getToken() {
    var map = new Map<String, dynamic>();
    map['user_email'] = 'deni@gmail.com';
    map['user_password'] = '123456';
    var url = baseUrl + "users/login";
    print(url);
    return http.post(url, body: map);
  }

  static Future createUser(body) {
    var url = Uri.https(api_url, wp + 'users');
    try {
      return http.post(
        url,
        body: body,
        headers: {"Content-Type": "application/json", HttpHeaders.authorizationHeader: "$basicAuth"},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future getUser(email) {
//    var url = Uri.https('m-bangun.com/wp-json/wp/v2/users?search' + email);
    var url = baseURL + '/wp-json/wp/v2/users?search=' + email;
    print(url);
    try {
      return http.get(
        url,
        headers: {"Content-Type": "application/json", HttpHeaders.authorizationHeader: "$basicAuth"},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future uploadImage(File image, userid) async {
    final mimeTypeData = lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(baseUrl + '/Users/editFoto'));
    final file = await http.MultipartFile.fromPath('image', image.path, contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
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

  static Future updateAkun(File _imageFileSiup, File _imageFileAkte, File _imageFileKtp, idKategori, idSubKategori, namaPerusahaan, userId) async {
    if (userId != null) {
      final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(baseUrl + '/Users/updateAkunPremium'));

      // Intilize the multipart request
      if (idKategori == '1' || idKategori == '4') {
        print('kontraktor');
        final mimeTypeData1 = lookupMimeType(_imageFileSiup.path, headerBytes: [0xFF, 0xD8]).split('/');
        final fileSiup = await http.MultipartFile.fromPath('imageFileSiup', _imageFileSiup.path, contentType: MediaType(mimeTypeData1[0], mimeTypeData1[1]));

        final mimeTypeData2 = lookupMimeType(_imageFileAkte.path, headerBytes: [0xFF, 0xD8]).split('/');
        final fileAkte = await http.MultipartFile.fromPath('imageFileAkte', _imageFileAkte.path, contentType: MediaType(mimeTypeData2[0], mimeTypeData2[1]));

        imageUploadRequest.fields['ext'] = mimeTypeData1[1];
        imageUploadRequest.files.add(fileSiup);
        imageUploadRequest.files.add(fileAkte);
        imageUploadRequest.fields['userPerusahaan'] = namaPerusahaan;
      }
      if (idKategori == '2') {
        print('pemborong');
        final mimeTypeData1 = lookupMimeType(_imageFileKtp.path, headerBytes: [0xFF, 0xD8]).split('/');
        final fileKtp = await http.MultipartFile.fromPath('imageFileKtp', _imageFileKtp.path, contentType: MediaType(mimeTypeData1[0], mimeTypeData1[1]));

        imageUploadRequest.fields['ext'] = mimeTypeData1[1];
        imageUploadRequest.files.add(fileKtp);
      }
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

  static Future updateAkunPremium(body) {
    var url = baseUrl + "Users/updateDataAkunPremium";
    return http.post(url, body: body);
  }

  static Future pengajuanRqt(File produkthumbnail, File produkfoto1, File produkfoto2, File produkfoto3, File produkfoto4, idprovinsi, idkota, idkecamatan, alamatlengkap,
      produknama, produkpanjang, produklebar, produktinggi, produkbahan, produkwaktupengerjaan, produkbudget, userid, token) async {
    final mimeTypeprodukthumbnail = lookupMimeType(produkthumbnail.path, headerBytes: [0xFF, 0xD8]).split('/');
    final mimeTypeprodukfoto1 = lookupMimeType(produkfoto1.path, headerBytes: [0xFF, 0xD8]).split('/');
    final mimeTypeprodukfoto2 = lookupMimeType(produkfoto2.path, headerBytes: [0xFF, 0xD8]).split('/');
    final mimeTypeprodukfoto3 = lookupMimeType(produkfoto3.path, headerBytes: [0xFF, 0xD8]).split('/');
    final mimeTypeprodukfoto4 = lookupMimeType(produkfoto4.path, headerBytes: [0xFF, 0xD8]).split('/');
    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(baseUrl + 'Pengajuan/pengajuanRqt'));

    final _produkthumbnail =
        await http.MultipartFile.fromPath('produkthumbnail', produkthumbnail.path, contentType: MediaType(mimeTypeprodukthumbnail[0], mimeTypeprodukthumbnail[1]));
    final _produkfoto1 = await http.MultipartFile.fromPath('produkfoto1', produkfoto1.path, contentType: MediaType(mimeTypeprodukfoto1[0], mimeTypeprodukfoto1[1]));
    final _produkfoto2 = await http.MultipartFile.fromPath('produkfoto2', produkfoto2.path, contentType: MediaType(mimeTypeprodukfoto2[0], mimeTypeprodukfoto2[1]));
    final _produkfoto3 = await http.MultipartFile.fromPath('produkfoto3', produkfoto3.path, contentType: MediaType(mimeTypeprodukfoto3[0], mimeTypeprodukfoto3[1]));
    final _produkfoto4 = await http.MultipartFile.fromPath('produkfoto4', produkfoto4.path, contentType: MediaType(mimeTypeprodukfoto4[0], mimeTypeprodukfoto4[1]));
// Declace data to post
    imageUploadRequest.fields['ext'] = mimeTypeprodukthumbnail[1];

    imageUploadRequest.fields['produkpanjang'] = produkpanjang;
    imageUploadRequest.fields['produknama'] = produknama;
    imageUploadRequest.fields['produklebar'] = produklebar;
    imageUploadRequest.fields['produktinggi'] = produktinggi;
    imageUploadRequest.fields['produkdeskripsi'] = produkbahan;
    imageUploadRequest.fields['produkbudget'] = produkbudget;
    imageUploadRequest.fields['produkalamat'] = alamatlengkap;
    imageUploadRequest.fields['id_provinsi'] = idprovinsi;
    imageUploadRequest.fields['id_kota'] = idkota;
    imageUploadRequest.fields['id_kecamatan'] = idkecamatan;
    imageUploadRequest.fields['produkwaktupengerjaan'] = produkwaktupengerjaan;
    imageUploadRequest.fields['userid'] = userid;
    Map<String, String> headers = {"Authorization": token};
    imageUploadRequest.headers.addAll(headers);
    // Iterable iterable =  foto;
    imageUploadRequest.files.addAll([_produkthumbnail, _produkfoto1, _produkfoto2, _produkfoto3, _produkfoto4]);
    print('test');
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

  static Future register(body) {
    var url = baseUrl + "Users/register";
    return http.post(url, body: body);
  }

  static Future simpanDataProfile(body) {
    var url = baseUrl + "Users/updateDataAkun";
    print(url);
    return http.post(url, body: body);
  }

  static Future login(body) {
    var url = baseUrl + "Users/login";
    return http.post(url, body: body);
  }

  static Future getAllKategori(token) {
    var url = baseUrl + "kategori/getAll";
    return http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }

  static Future updateBidToKontrakByIdUser(token, body) {
    var url = baseUrl + "Bid/updateBids";
    print(url);
    return http.post(
      url,
      body: body,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }

  static Future getAllJenisPengajuan(token) {
    var url = baseUrl + "JenisPengajuan/getAll";

    return http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }

  static Future getAllKategoriByFilterParam(token, akses, req) {
    var _akses = (akses == '' ? '' : 'akses=' + akses);
    var _req = (req == '' ? '' : '&req=' + req);
    var url = baseUrl + "kategori/getAllByFilterParam?" + _akses + _req;
    return http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }

  static Future getUserById(token, userid) {
    var url = baseUrl + "Users/getById?userid=" + userid;
    print(url);
    return http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }

  static Future getAllSubKategoriByIdKategori(token, idKategori) {
    var url = baseUrl + "SubKategori/getAllByIdKategori/" + idKategori;
    try {
      return http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future getNewsById(token, id) {
    var _id = (id == '' ? '' : 'id=' + id);
    var url = baseUrl + "News/getById/?" + _id;
    try {
      return http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future getAllSubKategori(token) {
    var url = baseUrl + "SubKategori/getAll";
    try {
      return http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future getAllProvinsi(token) {
    var url = baseUrl + "Provinsi/getAll";
    try {
      return http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future getProvinsiById(token, idProvinsi) {
    var url = baseUrl + "Provinsi/getById/" + idProvinsi;
    try {
      return http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future getAllKotaByIdProvinsi(token, idProvinsi) {
    var url = baseUrl + "kota/getAllByIdProvinsi/" + idProvinsi;
    try {
      return http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future getKotaById(token, idKota) {
    var url = baseUrl + "kota/getById/" + idKota;
    try {
      return http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future getAllKecamatanByIdKota(token, idKota) {
    var url = baseUrl + "kecamatan/getAllByIdKota/" + idKota;
    try {
      return http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future getKecamatanById(token, idKota) {
    var url = baseUrl + "kecamatan/getById/" + idKota;
    try {
      return http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future getAllNews(token) {
    var url = baseUrl + "news/getAll";
    try {
      return http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future getAllProdukByParam(token, query) {
    var url = Uri.http(api_url, param + 'produk/getAllByParam', query);
    print(url);
    try {
      return http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

//  static Future getAllProdukByUserId(token, userId, status) {
//    var _userId = (userId == '' ? '' : '&userid=' + userId);
//    var _status = (status == '' ? '' : '&stp=' + status);
//    var url = baseUrl + "produk/getAllByParam?" + _userId + _status;
//    try {
//      var result = http.get(
//        url,
//        headers: {HttpHeaders.authorizationHeader: token},
//      );
//      return result;
//    } catch (e) {
//      print(e);
//    }
//  }

  static Future insertPelatihanKerja(token, body) {
    var url = baseUrl + "PelatihanKerja/insertPelatihanKerja";
    try {
      return http.post(
        url,
        body: body,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future getAllFavoriteByParam(token, query) {
    var url = Uri.http(api_url, param + '/Favorite/getAllByFilterParam', query);
//    var url = baseUrl + "Favorite/getAllByFilterParam?" + _produkId + _userId;
    print(url);
    try {
      return http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future createFavoriteByUserId(token, body) {
    var url = baseUrl + "Favorite/createFavorite";
    try {
      return http.post(
        url,
        body: body,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future deleteFavoriteByUserIdAndProdukId(token, body) {
    var url = baseUrl + "Favorite/deleteFavorite";
    try {
      return http.post(
        url,
        body: body,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future createSignature(token, body) {
    var url = baseUrl + "Signature/base64_to_jpeg";
    try {
      return http.post(
        url,
        body: body,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future addBids(token, body) {
    var url = baseUrl + "Bid/addBidByUserId";
    try {
      return http.post(
        url,
        body: body,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future getBidByParam(token, query) {
    var url = Uri.http(api_url, param + '/Bid/getBidByParam', query);
    print(url);
    try {
      return http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future getKontrakByParam(token, query) {
    var url = Uri.http(api_url, param + 'Kontrak/getKontrakByParam', query);
    print(url);
    try {
      return http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future getAllGroupKategori(token, query) {
    var url = Uri.http(api_url, param + 'GroupKategori/getAllByParam', query);
    print(url);
    try {
      return http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future getAllInvoiceByParam(token, query) {
    var url = Uri.http(api_url, param + 'Invoice/getAllInvoiceByParam', query);
    print(url);
    try {
      return http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future getCategories(token, req) {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('${token['username']}:${token['password']}'));
    var url = Uri.http(api_url, param + 'products/categories', req);
    try {
      return http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: "$basicAuth"},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future getAllGroupByParam(token, query) {
    var url = Uri.http(api_url, param + 'Kategori/getAllGroupByParam', query);
    print(url);
    try {
      return http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future getNewVersion(token) {
    var url = Uri.http(api_url, param + 'ChekVersion/getLastVersion');
    print(url);
    try {
      return http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future getAllBank(token) {
    var url = Uri.http(api_url, param + 'Sistem/getAllBank');
    print(url);
    try {
      return http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future getAllMetodeTransfer(token) {
    var url = Uri.http(api_url, param + 'Sistem/getAllMetodeTransfer');
    print(url);
    try {
      return http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
    } catch (err) {
      print(err);
    }
  }
}
