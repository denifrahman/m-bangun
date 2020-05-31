import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "http://idwebdesainer.com/demo/api_cinta_rakyat_app/";
//const baseUrl = "http://192.168.0.9:8888/apps/api/";

class Kota {
  static Future getAll() {
    var url = baseUrl + "Kota/get_all_data";
    print(url);
    return http.get(url);
  }

  static Future edit(body) {
    var url = baseUrl + "daftar/ubah";
    print(body);
    return http.post(url, body: body);
  }
}
