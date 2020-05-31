import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "http://idwebdesainer.com/demo/api_cinta_rakyat_app/auth/";
//const baseUrl = "http://192.168.0.9:8888/apps/api/auth/";

class ApiAuth {
  static Future chekEmail(String email) {
    var url = baseUrl + "get_akun_by_email?email=" + email;
//    print(url);
    return http.get(url);
  }
}
