import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "http://idwebdesainer.com/demo/api_cinta_rakyat_app/";
//const baseUrl = "http://192.168.0.9:8888/apps/api/";

class Akun {
  static Future add(body) {
    var url = baseUrl + "daftar/add";
    print(body);
    return http.post(url, body: body);
  }

  static Future edit(body) {
    var url = baseUrl + "daftar/ubah";
    print(body);
    return http.post(url, body: body);
  }

  static Future getNewVersion() {
    var url = baseUrl + "t_chek_version/getnewVersion";
    return http.get(url);
  }
}
