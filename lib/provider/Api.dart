import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

const baseUrl = "http://niagatravel.com/api/api-m-bangun-jwt-token/api/";
//const baseUrl = "http://localhost:8888/api_jwt/api/";

class Api {

  static Future getToken() {
    Map data = {'usernama': 'deni', 'userpassword': '123'};
    var map = new Map<String, dynamic>();
    map['usernama'] = 'deni';
    map['userpassword'] = '123';
    var url = baseUrl + "users/login";
    return http.post(url,body: map);
  }
  static Future getKategori(token) {
    var url = baseUrl + "kategori/getAll";
    return http.get(url,
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
    return http.get(url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }
  static Future getProvinsiById(token, idProvinsi) {
    var url = baseUrl + "Provinsi/getById/"+idProvinsi;
    return http.get(url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }
  static Future getAllKotaByIdProvinsi(token,idProvinsi) {
    var url = baseUrl + "kota/getAllByIdProvinsi/" + idProvinsi;
    return http.get(url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }
  static Future getKotaById(token, idKota) {
    var url = baseUrl + "kota/getById/"+idKota;
    return http.get(url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }
  static Future getAllKecamatanByIdKota(token,idKota) {
    var url = baseUrl + "kecamatan/getAllByIdKota/" + idKota;
    return http.get(url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }
  static Future getKecamatanById(token, idKota) {
    var url = baseUrl + "kecamatan/getById/"+idKota;
    return http.get(url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }

  static Future getAllNews(token) {
    var url = baseUrl + "news/getAll";
    return http.get(url,
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
    return http.get(url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
  }
}
