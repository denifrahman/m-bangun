import 'package:http/http.dart' as http;

const baseUrl = 'm-bangun.com';
const controller = 'api-v2/';

class ApiGet {
  static Future getKecamatan(param) {
    var url = Uri.http(baseUrl, controller + 'Kecamatan/getAllByParam', param);
    return http.get(url);
  }

  static Future getUser(param) {
    var url = Uri.http(baseUrl, controller + 'user/getAllByParam', param);
    return http.get(url);
  }
}
