import 'package:http/http.dart' as http;

const baseUrl = 'localhost';
const controller = 'api-mbangun/';

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
