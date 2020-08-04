import 'package:apps/Repository/AuthRepository.dart';
import 'package:apps/Repository/UserRepository.dart';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class BlocAuth extends ChangeNotifier {
  BlocAuth() {
    checkSession();
  }

  bool _isLoading = true;
  bool _isLogin = false;
  bool _isRegister = false;
  String _errorMessage, _idUser, _token;
  bool _connection = true;

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
      _isLogin = false;
      _isRegister = false;
      notifyListeners();
      _googleSignIn.isSignedIn().then((value) {
        if (value) {
          checkSession();
          return true;
        } else {
          LocalStorage.sharedInstance.deleteValue('id_user_login');
          checkSession();
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
      notifyListeners();
      return result;
    } else {
      return result;
    }
  }

  checkSession() async {
    print(_googleSignIn.isSignedIn());
    _isLoading = false;
    _googleSignIn.isSignedIn().then((value) async {
      _isLoading = true;
      if (value) {
        print('false');
        _isLogin = true;
        _isLoading = false;
        _currentUser = _googleSignIn.currentUser;
        notifyListeners();
        var queryString = {'username': _currentUser.email, 'id_google': _currentUser.id};
        var result = await AuthRepository().googleSign(queryString);
        if (result.toString() == '111' || result.toString() == '101') {
          _connection = true;
          _isLogin = false;
          _isRegister = true;
          _isLoading = false;
          notifyListeners();
          return false;
        } else {
          if (result['meta']['success']) {
            _connection = true;
            _token = result['token'];
            LocalStorage.sharedInstance.writeValue(key: 'id_user_login', value: result['data']['id']);
            _idUser = result['data']['id'];
            _isRegister = false;
            _isLoading = false;
            notifyListeners();
            return true;
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
    _googleSignIn.signInSilently();
  }
}
