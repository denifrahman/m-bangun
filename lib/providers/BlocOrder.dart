import 'package:apps/Repository/OrderRepository.dart';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/Cart.dart';
import 'package:flutter/cupertino.dart';

class BlocOrder extends ChangeNotifier {
  BlocOrder() {
    setIdUser();
  }

  String _id_user_login;

  String get id_user_login => _id_user_login;

  setIdUser() async {
    var id = await LocalStorage.sharedInstance.readValue('id_user_login');
    if (id != null) {
      _id_user_login = id;
    } else {
      _id_user_login = '0';
    }
    getCart();
    notifyListeners();
  }

  bool _connection = false;
  bool _isLoading = false;
  int _jumlah = 1;
  String _catatan = '';

  int get jumlah => _jumlah;

  String get catatan => _catatan;

  setJumlah(int value) {
    _jumlah = value;
    print(value);
    notifyListeners();
  }

  setCatatan(String value) {
    _catatan = value;
    notifyListeners();
  }

  bool get connection => _connection;

  bool get isLoading => _isLoading;
  List<Cart> _listCart = [];

  List<Cart> get listCart => _listCart;

  removeCart(id) async {
    var body = new Map<String, String>();
    body['id'] = id.toString();
    var result = await OrderRepository().removeCart(body);
    if (result['meta']['success']) {
      getCart();
    }
    notifyListeners();
  }

  updateCart(body) async {
    var result = await OrderRepository().updateCart(body);
    print(result);
    if (result['meta']['success']) {
      getCart();
      notifyListeners();
    }
  }

  clearCart() {
    _listCart = [];
    notifyListeners();
  }

  addToCart(body) async {
    var result = await OrderRepository().addToCart(body);
    if (result.toString() == '111' || result.toString() == '101') {
      _connection = false;
      getCart();
      notifyListeners();
      return false;
    } else {
      if (result['meta']['success']) {
        getCart();
        _connection = true;
        notifyListeners();
        return true;
      } else {
        _connection = false;
        notifyListeners();
        return false;
      }
    }
  }

  getCart() async {
    _isLoading = true;
    notifyListeners();
    var param = {'id_user_login': _id_user_login.toString()};
    var result = await OrderRepository().getCart(param);
    print(result);
    if (result.toString() == '111' || result.toString() == '101') {
      _connection = false;
      _isLoading = false;
      _listCart = [];
      notifyListeners();
      return false;
    } else {
      if (result['meta']['success']) {
        _isLoading = false;
        _connection = true;
        Iterable list = result['data'];
        _listCart = list.map((model) => Cart.fromMap(model)).toList();
        notifyListeners();
        return true;
      } else {
        _connection = false;
        _isLoading = false;
        _listCart = [];
        notifyListeners();
        return false;
      }
    }
  }
}
