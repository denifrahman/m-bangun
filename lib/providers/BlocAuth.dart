import 'dart:convert';

import 'package:apps/Repository/AuthRepository.dart';
import 'package:apps/Repository/UserRepository.dart';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/models/Mitra.dart';
import 'package:apps/screen/PhoneAuth/presentation/pages/firebase/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:package_info/package_info.dart';

class BlocAuth extends ChangeNotifier {
  BlocAuth() {
    // initChat();
  }

  bool _isLoading = false;
  bool _isLogin = false;
  String _statusToko = '0';
  String _idToko = '0';
  bool _isRegister = false;
  String _errorMessage, _idUser, _token, _id_user;
  bool _connection = true;
  bool _isNonActive = false;
  String fcmToken;

  bool get isNonActive => _isNonActive;

  String get statusToko => _statusToko;

  String get idToko => _idToko;

  bool get connection => _connection;

  String get errorMessage => _errorMessage;

  bool get isRegister => _isRegister;

  bool get isLoading => _isLoading;

  String get idUser => _idUser;

  String get id_user => _id_user;

  bool get isLogin => _isLogin;

  var _currentUserAuth;

  get currentUserAuth => _currentUserAuth;

  double _currentVersion;

  double _newVersion;

  bool _showVersionDialog = false;

  bool get showVersionDialog => _showVersionDialog;

  double get currentVersion => _currentVersion;

  double get newVersion => _newVersion;

  Future initChat() async {
    _isLoading = true;
    notifyListeners();
    var map = new Map<String, String>();
    map["id"] = _phoneNumber.replaceAll('+628', '08');
    map["name"] =
        _currentUserLogin['nama'] ?? _phoneNumber;
    map["image"] = _currentUserLogin['photo_url'] ?? imageNull;
    map["role"] = 'user';
    print(map.toString() + ' inichat');
    var result = await getOrCreate(map);
    if (result['success']) {
      LocalStorage.sharedInstance
          .writeValue(key: 'chatToken', value: json.encode(result));
    }
    ;
    _isLoading = false;
    notifyListeners();
    return result;
  }

  handleSignOut() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 3));
    var fcmToken = FlutterSession().get('fcm_token');
    fcmToken.then((value) async {
      var param = {'fcm_token': value};
      var result = await AuthRepository().deleteFcmToken(param);
      print(result);
    });
    LocalStorage.sharedInstance.deleteValue('no_telp');
    LocalStorage.sharedInstance.deleteValue('id_toko');
    LocalStorage.sharedInstance.deleteValue('userData');
    LocalStorage.sharedInstance.deleteValue('chatToken');
    checkSession();
    _isLoading = false;
    notifyListeners();
  }

  create(body) async {
    await UserRepository().create(body);
    _getOrCreateUserData();
  }

  update(body) async {
    var result = await UserRepository().update(body);
    if (result['meta']['success']) {
      _isLogin = true;
      checkSession();
      notifyListeners();
      return result;
    } else {
      checkSession();
      return result;
    }
  }

  Map<String, dynamic> _currentUserLogin = {};

  Map<String, dynamic> get currentUserLogin => _currentUserLogin;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  setFcmToken(String token) async {
    var deviceData = FlutterSession().get('deviceData');
    deviceData.then((value) async {
      var devices = value['name'] == null ? value['brand'] : value['name'];
      var system =
          value['systemName'] == null ? 'Android' : value['systemName'];
      var param = {
        'id_user': idUser.toString(),
        'fcm_token': token.toString(),
        'device_name': devices,
        'system_name': system,
        'model': value['model']
      };
      print(param);
      var result = await AuthRepository().setFcmToken(param);
      print(result.toString() + ' fcmtoken');
    });
  }

  String _phoneNumber = '';

  String get phoneNumber => _phoneNumber;

  setPhoneNumber(phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  Future checkSession() async {
    checkVersionApp();
    await _getOrCreateUserData();
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> _getOrCreateUserData() async {
    print('_getOrCreateUserData');
    _currentUserLogin = {};
    _isLoading = true;
    notifyListeners();
    var queryString = {'no_hp': ('+' + _phoneNumber)};
    var result = await AuthRepository().getUserByParam(queryString);
    print(result);
    if (result['data'].length < 1) {
      await create(queryString);
    } else {
      if (result['meta']['success']) {
        _currentUserLogin = result['data'][0];
        _statusToko = result['data'][0]['status_toko'];
        if (result['data'][0]['aktif'] != '1') {
          _isNonActive = true;
          _connection = true;
          _isLogin = false;
          notifyListeners();
          await Future.delayed(Duration(milliseconds: 1), () {
            handleSignOut();
          });
          return false;
        } else {
          _connection = true;
          _token = result['token'];
          _idToko = result['data'][0]['id_toko'];
          LocalStorage.sharedInstance
              .writeValue(key: 'id_toko', value: result['data'][0]['id_toko']);
          LocalStorage.sharedInstance
              .writeValue(key: 'id_user', value: result['data'][0]['id']);
          _idUser = result['data'][0]['id'];
          var fcmToken = await FlutterSession().get('fcm_token');
          await setFcmToken(fcmToken);
          _isLoading = false;
          _isLogin = true;
          notifyListeners();
          return true;
        }
      }
    }
  }

  setShowVersionDialog(bool) {
    _showVersionDialog = bool;
  }

  checkVersionApp() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    _currentVersion = double.parse(info.version.trim().replaceAll(".", ""));
    notifyListeners();
    var param = {'': ''};
    var result = await AuthRepository().checkVersionApp(param);
    if (result.toString() == '111' ||
        result.toString() == '101' ||
        result.toString() == 'Conncetion Error') {
      _connection = false;
      _isLoading = false;
      notifyListeners();
      return result;
    } else {
      _newVersion = double.parse(
          result['data'][0]['versi_nomor'].trim().replaceAll(".", ""));
      if (newVersion > currentVersion) {
        _showVersionDialog = true;
        notifyListeners();
      }
    }
  }

  List _listNotification = [];

  List get listNotification => _listNotification;

  getNotification() async {
    var param = {'id_user': _idUser, 'limit': '20'};
    var result = await AuthRepository().getNotification(param);
    if (result.toString() == '111' ||
        result.toString() == '101' ||
        result.toString() == 'Conncetion Error') {
      _connection = false;
      _isLoading = false;
      notifyListeners();
      return result;
    } else {
      if (result['meta']['success']) {
        _isLoading = false;
        _connection = true;
        _listNotification = [];
        Iterable list = result['data'];
        _listNotification = result['data'];
        notifyListeners();
        getNotificationUnread();
        return result['data'];
      } else {
        getNotificationUnread();
        _connection = false;
        _isLoading = false;
        _listNotification = [];
        notifyListeners();
        return result['data'];
      }
    }
  }

  int _coundNotification = 0;

  int get coundNotification => _coundNotification;

  getNotificationUnread() async {
    var param = {
      'id_user': idUser.toString(),
      'status': 'unread',
      "limit": '20'
    };
    var result = await AuthRepository().getNotification(param);
    if (result.toString() == '111' ||
        result.toString() == '101' ||
        result.toString() == 'Conncetion Error') {
      _connection = false;
      _isLoading = false;
      notifyListeners();
      return result;
    } else {
      if (result['meta']['success']) {
        _coundNotification = result['data'].length;
        notifyListeners();
      } else {
        _coundNotification = result['data'].length;
      }
    }
  }

  updateNotification(param) async {
    var result = await AuthRepository().updateNotification(param);
    getNotification();
    notifyListeners();
  }

  Future getOrCreate(body) async {
    var result = await AuthRepository().getOrCreate(body);
    return result;
  }

  List<Mitra> _listMitra = [];

  List<Mitra> get listMitra => _listMitra;

  getMitraByParam(param) async {
    _isLoading = true;
    notifyListeners();
    var result = await AuthRepository().getMitraByParam(param);
    print(result);
    if (result.toString() == '111' ||
        result.toString() == '101' ||
        result.toString() == 'Conncetion Error') {
      _connection = false;
      _isLoading = false;
      notifyListeners();
    } else {
      _isLoading = false;
      _connection = true;
      Iterable list = result['data'];
      _listMitra = list.map((e) => Mitra.fromJson(e)).toList();
      notifyListeners();
    }
  }
}
