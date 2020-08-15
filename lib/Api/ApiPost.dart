import 'package:http/http.dart' as http;

const baseUrl = 'm-bangun.com';
const controller = 'api-v2/';

class ApiPost {
  static Future auth(body) {
    var url = Uri.http(baseUrl, controller + 'token/googleSign');
    try {
      return http.post(
        url,
        body: body,
//        headers: {"Content-Type": "application/json", HttpHeaders.authorizationHeader: "$basicAuth"},
      );
    } catch (err) {
      print(err);
    }
  }

  static Future createUser(body) {
    var url = Uri.http(baseUrl, controller + 'user/create');
    try {
      return http.post(
        url,
        body: body,
//        headers: {"Content-Type": "application/json", HttpHeaders.authorizationHeader: "$basicAuth"},
      );
    } catch (err) {
      print(err);
    }
  }
}
