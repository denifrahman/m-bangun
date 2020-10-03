import 'package:apps/Api/ApiBaseHelper.dart';

class AuthRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future googleSign(body) async {
    final response = await _helper.post("token/googleSign", body);
    return response;
  }

  Future checkVersionApp(param) async {
    final response = await _helper.get("version/getAllByParam", param);
    return response;
  }

  Future getNotification(param) async {
    final response = await _helper.get("notification/getAllNotifUserByParam", param);
    return response;
  }

  Future setFcmToken(param) async {
    final response = await _helper.post("user/insertSessionLoginUser", param);
    return response;
  }

  Future updateNotification(param) async {
    final response = await _helper.post("notification/updateNotificationUser", param);
    return response;
  }

  Future deleteFcmToken(param) async {
    final response = await _helper.post("user/deleteSessionLoginUser", param);
    return response;
  }

  Future create(body) async {
    final response = await _helper.post("user/insert", body);
    return response;
  }
}
