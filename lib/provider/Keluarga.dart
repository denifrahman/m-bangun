import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "http://idwebdesainer.com/demo/api_cinta_rakyat_app/";
//const baseUrl = "http://192.168.0.9:8888/apps/api/";

class Keluarga {
  static Future getAnggotaKeluarga(id) {
    var url = baseUrl + "Keluarga/get_all_data_by_id?m_akun_id=" + id;
    print(url);
    return http.get(url);
  }

  static Future edit(body) {
    var url = baseUrl + "Keluarga/ubah";
    return http.post(url, body: body);
  }

  static Future add(body) {
    var url = baseUrl + "Keluarga/add";
    print(body);
    return http.post(url, body: body);
  }

  static Future delete(id) {
    var url = baseUrl + "Keluarga/delete_by_id?id=" + id;
    print(url);
    return http.get(url);
  }
}
