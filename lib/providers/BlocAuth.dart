import 'dart:convert';

import 'package:apps/Repository/AuthRepository.dart';
import 'package:apps/Repository/UserRepository.dart';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info/package_info.dart';

class BlocAuth extends ChangeNotifier {
  BlocAuth() {
    getCurrentUser();
    getNotification();
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
  GoogleSignInAccount _currentUser;

  GoogleSignInAccount get currentUser => _currentUser;

  handleSignIn() async {
    try {
      var login = await _googleSignIn.signIn();
      var fcm_token = FlutterSession().get('fcm_token');
      fcm_token.then((value) async {
        var queryString = {'username': login.email, 'id_google': login.id};
        var result = await AuthRepository().googleSign(queryString);
        setFcmToken(result['data']['id_user'], value);
        checkSession();
      });
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>['email'],
  );

  handleSignOut() async {
    _googleSignIn.disconnect().then((value) async {
      LocalStorage.sharedInstance.deleteValue('id_user_login');
      LocalStorage.sharedInstance.deleteValue('id_toko');
      LocalStorage.sharedInstance.deleteValue('userData');
      var fcm_token = FlutterSession().get('fcm_token');
      fcm_token.then((value) async {
        var param = {'fcm_token': value};
        var result = await AuthRepository().deleteFcmToken(param);
      });
      checkSession();
//      _googleSignIn.isSignedIn().then((value) {
//        if (value) {
//          return true;
//        } else {
//          _isLogin = false;
//          _idToko = '0';
//          _idUser = '0';
//          _connection = true;
//          _isNonActive = false;
//          _isRegister = false;
//          notifyListeners();
//          return false;
//        }
//      });
    });
  }

  create(body) async {
    var result = await UserRepository().create(body);
    if (result['meta']['success']) {
      _isLogin = true;
      _isRegister = false;
      checkSession();
      notifyListeners();
      return result;
    } else {
      checkSession();
      return result;
    }
  }

  getCurrentUser() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      _currentUser = account;
      if (account != null) {
        checkSession();
      } else {
        handleSignOut();
      }
    });
    _googleSignIn.signInSilently();
  }

  Map<String, dynamic> _currentUserLogin = {};

  Map<String, dynamic> get currentUserLogin => _currentUserLogin;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  setFcmToken(String id_user, String token) async {
    var deviceData = FlutterSession().get('deviceData');
    deviceData.then((value) async {
      var devices = value['name'] == null ? value['brand'] : value['name'];
      var system = value['systemName'] == null ? 'Android' : value['systemName'];
      var param = {'id_user': id_user.toString(), 'fcm_token': token.toString(), 'device_name': devices, 'system_name': system, 'model': value['model']};
      print(param);
      var result = await AuthRepository().setFcmToken(param);
    });
  }

  checkSession() async {
    checkVersionApp();
    _isLoading = false;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 1), () {
      _googleSignIn.isSignedIn().then((value) async {
        if (value) {
          if (_currentUser == null) {
            getCurrentUser();
            _connection = true;
            _isLoading = false;
            _isLogin = false;
            notifyListeners();
          } else {
            getUserData();
          }
        } else {
          print('logout');
          _connection = true;
          _isLogin = false;
          _isLoading = false;
          _isRegister = false;
          notifyListeners();
          return false;
        }
      });
    });
  }

  getUserData() async {
    var queryString = {'username': _currentUser.email, 'id_google': _currentUser.id};
    var result = await AuthRepository().googleSign(queryString);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == 'Conncetion Error') {
      _connection = false;
      _isLoading = false;
      notifyListeners();
      return false;
    } else {
      if (result['meta']['success']) {
        _currentUserLogin = result['data'];
        _statusToko = result['data']['status_toko'];
        if (result['data']['aktif'] != '1') {
          _isNonActive = true;
          _connection = true;
          _isLogin = false;
          notifyListeners();
          await Future.delayed(Duration(milliseconds: 1), () {
            handleSignOut();
          });
        } else {
          _connection = true;
          _token = result['token'];
          _idToko = result['data']['id_toko'].toString();
          LocalStorage.sharedInstance.writeValue(key: 'id_toko', value: result['data']['id_toko']);
          await FlutterSession().set('userData', json.encode(result['data']));
          LocalStorage.sharedInstance.writeValue(key: 'id_user_login', value: result['data']['id']);
          _idUser = result['data']['id'];
          _id_user = result['data']['id_user'];
          _isRegister = false;
          _isLoading = false;
          _isLogin = true;
          notifyListeners();
          return true;
        }
      } else {
        _connection = true;
        _isRegister = true;
        _isLoading = false;
        _isLogin = false;
        notifyListeners();
      }
    }
  }

  double _currentVersion;
  double _newVersion;
  bool _showVersionDialog = false;

  bool get showVersionDialog => _showVersionDialog;

  double get currentVersion => _currentVersion;

  double get newVersion => _newVersion;

  setShowVersionDialog(bool) {
    _showVersionDialog = bool;
  }

  checkVersionApp() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    _currentVersion = double.parse(info.version.trim().replaceAll(".", ""));
    notifyListeners();
    var param = {'': ''};
    var result = await AuthRepository().checkVersionApp(param);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == 'Conncetion Error') {
      _connection = false;
      _isLoading = false;
      notifyListeners();
      return result;
    } else {
      _newVersion = double.parse(result['data'][0]['versi_nomor'].trim().replaceAll(".", ""));
      if (newVersion > currentVersion) {
        _showVersionDialog = true;
        notifyListeners();
      }
    }
  }

  List _listNotification = [];

  List get listNotification => _listNotification;

  getNotification() async {
    _isLoading = true;
    var param = {'id_user': _id_user.toString(), 'limit': '20'};
    var result = await AuthRepository().getNotification(param);
    print(param);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == 'Conncetion Error') {
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
    var param = {'id_user': _id_user.toString(), 'status': 'unread', "limit": '20'};
    var result = await AuthRepository().getNotification(param);
//    print(result);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == 'Conncetion Error') {
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
//    print(result);
    getNotification();
    notifyListeners();
  }
}
