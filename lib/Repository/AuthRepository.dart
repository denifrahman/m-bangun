import 'package:apps/Api/ApiBaseHelper.dart';
import 'package:apps/Api/RestSendBird.dart';

class AuthRepository {
  ApiBaseHelper _helper = ApiBaseHelper();
  Rest rest = Rest();

  Future googleSign(body) async {
    final response = await _helper.post("token/googleSign", body);
    return response;
  }

  Future checkOtp(body) async {
    final response = await _helper.get("otp/checkOtp", body);
    return response;
  }
  
  Future sendOtp(body) async {
    final response = await _helper.post("otp/insert", body);
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

  Future getOrCreate(body) async {
    print(body.toString() + ' body create');
    final response = await _helper.post("chat/getOrCreateUser", body);
    return response;
  }

  Future getMitraByParam(param) async {
    final response = await _helper.get("mitra/getAllByParam", param);
    return response;
  }

  Future getUserByParam(param) async {
    final response = await _helper.get("user/getAllByParam", param);
    return response;
  }
}
