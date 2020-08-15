import 'package:http/http.dart' as http;

const baseUrl = 'localhost';
const controller = 'api-mbangun/';

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
