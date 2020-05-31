import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "http://idwebdesainer.com/demo/api_cinta_rakyat_app/";
//const baseUrl = "http://192.168.0.8:8888/apps/api/";

class Dashboard {
  static Future getGrafikPerBulan() {
    var url = baseUrl + "Dashboard/get_odp_per_bulan";
//    print(url);
    return http.get(url);
  }

  static Future getGrafikPerBulanPdp() {
    var url = baseUrl + "Dashboard/get_pdp_per_bulan";
//    print(url);
    return http.get(url);
  }

  static Future getAlldata() {
    var url = baseUrl + "Dashboard/get_pie";
//    print(url);
    return http.get(url);
  }

  static Future getPerKota() {
    var url = baseUrl + "Dashboard/get_per_kota";
    return http.get(url);
  }
}
