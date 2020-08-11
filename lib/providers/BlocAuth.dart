import 'package:apps/Repository/AuthRepository.dart';
import 'package:apps/Repository/UserRepository.dart';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info/package_info.dart';

class BlocAuth extends ChangeNotifier {
  BlocAuth() {
    checkSession();
  }

  bool _isLoading = true;
  bool _isLogin = false;
  bool _isRegister = false;
  String _errorMessage, _idUser, _token;
  bool _connection = true;
  bool _isNonActive = false;

  bool get isNonActive => _isNonActive;

  bool get connection => _connection;

  String get errorMessage => _errorMessage;

  bool get isRegister => _isRegister;

  bool get isLoading => _isLoading;

  String get idUser => _idUser;

  bool get isLogin => _isLogin;
  GoogleSignInAccount _currentUser;

  GoogleSignInAccount get currentUser => _currentUser;

  handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      checkSession();
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
    _googleSignIn.disconnect().then((value) {
      _googleSignIn.isSignedIn().then((value) {
        if (value) {
          checkSession();
          return true;
        } else {
          _isLogin = false;
          _isNonActive = false;
          _isRegister = false;
          notifyListeners();
          LocalStorage.sharedInstance.deleteValue('id_user_login');
          return false;
        }
      });
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

  checkSession() async {
    _isLoading = false;
    _googleSignIn.signInSilently();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) async {
      if (account != null) {
        _currentUser = account;
      }
    });
    _googleSignIn.isSignedIn().then((value) async {
      if (value) {
        var queryString = {'username': _currentUser.email, 'id_google': _currentUser.id};
        var result = await AuthRepository().googleSign(queryString);
        if (result.toString() == '111' || result.toString() == '101') {
          _connection = true;
          return false;
        } else {
          if (result['meta']['success']) {
            if (result['data']['aktif'] != '1') {
              _isNonActive = true;
              _isLogin = false;
              notifyListeners();
              await Future.delayed(Duration(seconds: 5), () {
                handleSignOut();
              });
            } else {
              _connection = true;
              _token = result['token'];
              LocalStorage.sharedInstance.writeValue(key: 'id_user_login', value: result['data']['id']);
              _idUser = result['data']['id'];
              _isRegister = false;
              _isLoading = false;
              _isLogin = true;
              notifyListeners();
              return true;
            }
          } else {
            _isRegister = true;
            _isLogin = false;
            notifyListeners();
          }
        }
      } else {
        print('logout');
        _isLogin = false;
        _isLoading = false;
        notifyListeners();
        return false;
      }
    });
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
    _newVersion = double.parse(result['data'][0]['versi_nomor'].trim().replaceAll(".", ""));
    if (newVersion > currentVersion) {
      _showVersionDialog = true;
      notifyListeners();
    }
  }
}
