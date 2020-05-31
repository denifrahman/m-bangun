import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "http://idwebdesainer.com/demo/api_cinta_rakyat_app/";
//const baseUrl = "http://192.168.0.9:8888/apps/api/";

class Kebutuhan {
  static Future getAll() {
    var url = baseUrl + "Kebutuhan/get_all_data";
    print(url);
    return http.get(url);
  }

  static Future getByidAkun(akunId) {
    var url = baseUrl + "Kebutuhan/get_all_data_by_id_akun?AkunId=" + akunId;
    print(url);
    return http.get(url);
  }

  static Future add(body) {
    var url = baseUrl + "Kebutuhan/add";
    print(body);
    return http.post(url, body: body);
  }

  static Future delete(id) {
    var url = baseUrl + "Kebutuhan/delete_by_id?id=" + id;
    print(url);
    return http.get(url);
  }
}
