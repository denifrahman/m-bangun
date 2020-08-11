import 'package:apps/Repository/UserRepository.dart';
import 'package:apps/models/Categories.dart';
import 'package:apps/models/OfficialStore.dart';
import 'package:apps/models/Product.dart';
import 'package:apps/models/RecentProduk.dart';
import 'package:apps/models/Toko.dart';
import 'package:flutter/cupertino.dart';

class BlocProduk extends ChangeNotifier {
  BlocProduk() {
    initLoad();
  }

  initLoad() {
    imageCache.clear();
    getOfficialStore();
    getCategory();
    getRecentProduct();
  }

  List<Toko> _toko = [
    Toko('https://m-bangun.com/wp-content/uploads/2020/07/contarctor.png', 'Boat roackerz 400 On-Ear Bluetooth Headphones', 'description', 120000, 2),
    Toko('https://m-bangun.com/wp-content/uploads/2020/07/properti-2.png', 'Boat roackerz 100 On-Ear Bluetooth Headphones', 'description', 122222, 1),
  ];

  bool _connection = false;
  bool _isLoading = false;

  bool get connection => _connection;

  bool get isLoading => _isLoading;

  List<Toko> get toko => _toko;

  remove(index) {
    _listProducts.remove(index);
    notifyListeners();
  }

  add(value, index) {
//    print(index.price);

    _listProducts.forEach((element) {
      if (element.harga == index.price) {
        element.stok = value;
        notifyListeners();
      }
      ;
    });
  }

  subTotal(index) {}

  List<Product> _listProducts = [];

  List<Product> get listProducts => _listProducts;
  List<Product> _detailProduct = [];

  List<Product> get detailProduct => _detailProduct;

  getAllProductByParam(param) async {
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var result = await UserRepository().getAllProduct(param);
    print(result);
    if (result.toString() == '111' || result.toString() == '101') {
      _connection = false;
      _isLoading = false;
      _listProducts = [];
      notifyListeners();
    } else {
      Iterable list = result['data'];
      _listProducts = list.map((model) => Product.fromMap(model)).toList();
      _detailProduct = list.map((model) => Product.fromMap(model)).toList();
      _isLoading = false;
      _connection = true;
      notifyListeners();
    }
  }

  List<OfficialStore> _detailStore = [];

  List<OfficialStore> get detailStore => _detailStore;

  getDetailStore(id) async {
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var param = {'id': id.toString()};
    var result = await UserRepository().getDetailStore(param);
    if (result.toString() == '111' || result.toString() == '101') {
      _connection = false;
      _detailStore = [];
      _isLoading = false;
      notifyListeners();
    } else {
      Iterable list = result['data'];
      _detailStore = list.map((model) => OfficialStore.fromMap(model)).toList();
      _connection = true;
      _isLoading = false;
      getProdukTerjual(id);
      getCategoryByToko(id);
      notifyListeners();
    }
  }

  List<OfficialStore> _listOfficialStore = [];

  List<OfficialStore> get listOfficialStore => _listOfficialStore;

  getOfficialStore() async {
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var param = {'': ''};
    var result = await UserRepository().getOfficialStore(param);
    if (result.toString() == '111' || result.toString() == '101') {
      _isLoading = false;
      _connection = false;
      _listOfficialStore = [];
      notifyListeners();
    } else {
      Iterable list = result['data'];
      _listOfficialStore = list.map((model) => OfficialStore.fromMap(model)).toList();
      _connection = true;
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Categories> _listCategory = [];

  List<Categories> get listCategory => _listCategory;

  getCategory() async {
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var param = {'show_on_homepage': '1'};
    var result = await UserRepository().getCategory(param);
    if (result.toString() == '111' || result.toString() == '101') {
      _connection = false;
      _isLoading = false;
      _listOfficialStore = [];
      notifyListeners();
    } else {
      Iterable list = result['data'];
      _listCategory = list.map((model) => Categories.fromMap(model)).toList();
      _connection = true;
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Categories> _listCategoryByToko = [];

  List<Categories> get listCategoryByToko => _listCategoryByToko;

  getCategoryByToko(id_toko) async {
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var param = {'id_toko': id_toko.toString()};
    var result = await UserRepository().getCategoryByToko(param);
    if (result.toString() == '111' || result.toString() == '101') {
      _connection = false;
      _isLoading = false;
      _listCategoryByToko = [];
      notifyListeners();
    } else {
      Iterable list = result['data'];
      _listCategoryByToko = list.map((model) => Categories.fromMap(model)).toList();
      _connection = true;
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Product> _listRecentProduct = [];

  List<Product> get listRecentProduct => _listRecentProduct;

  getRecentProduct() async {
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var param = {'': ''};
    var result = await UserRepository().getRecentProduct(param);
    if (result.toString() == '111' || result.toString() == '101') {
      _connection = false;
      _isLoading = false;
      _listOfficialStore = [];
      notifyListeners();
    } else {
      Iterable list = result['data'];
      _listRecentProduct = list.map((model) => Product.fromMap(model)).toList();
      _isLoading = false;
      _connection = true;
      notifyListeners();
    }
  }

  List<RecentProduk> _listProdukTerjual = [];

  List<RecentProduk> get listProdukTerjual => _listProdukTerjual;

  getProdukTerjual(id_toko) async {
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var param = {'id_toko': id_toko.toString()};
    var result = await UserRepository().getProdukTerjual(param);
    if (result.toString() == '111' || result.toString() == '101') {
      _connection = false;
      _isLoading = false;
      _listOfficialStore = [];
      notifyListeners();
    } else {
      Iterable list = result['data'];
      _listProdukTerjual = list.map((model) => RecentProduk.fromMap(model)).toList();
      _isLoading = false;
      _connection = true;
      notifyListeners();
    }
  }
}