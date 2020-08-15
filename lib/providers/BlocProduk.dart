import 'dart:io';

import 'package:apps/Repository/RajaOngkirRepository.dart';
import 'package:apps/Repository/UserRepository.dart';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/CategioryByToko.dart';
import 'package:apps/models/Categories.dart';
import 'package:apps/models/Iklan.dart';
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
    getCurrentLocation();
    getOfficialStore();
    getCategory();
    getRecentProduct();
    getIklan();
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
//    print(result);
    if (result.toString() == '111' || result.toString() == '101') {
      _connection = false;
      _isLoading = false;
      _listProducts = [];
      notifyListeners();
    } else {
      Iterable list = result['data'];
      _listProducts = list.map((model) => Product.fromMap(model)).toList();
      _isLoading = false;
      _connection = true;
      notifyListeners();
    }
  }

  clearDetailProduk() {
    _detailProduct = [];
    notifyListeners();
  }

  addCountViewProduk(body) async {
    var result = await UserRepository().addCountViewProduk(body);
    print(result);
  }

  getDetailProductByParam(param) async {
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var result = await UserRepository().getAllProduct(param);
    if (result.toString() == '111' || result.toString() == '101') {
      _connection = false;
      _isLoading = false;
      _detailProduct = [];
      notifyListeners();
    } else {
      var id = await LocalStorage.sharedInstance.readValue('id_user_login');
      var body = {'id_user_login': '1', 'id_produk': param['id'], 'id_user_login': id.toString()};
      addCountViewProduk(body);
      Iterable list = result['data'];
      _detailProduct = list.map((model) => Product.fromMap(model)).toList();
      _isLoading = false;
      _connection = true;
      notifyListeners();
    }
  }

  getFavoriteProductByParam(param) async {
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var result = await UserRepository().getFavoriteProduct(param);
    print(result);
    if (result.toString() == '111' || result.toString() == '101') {
      _connection = false;
      _isLoading = false;
      _listProducts = [];
      notifyListeners();
    } else {
      Iterable list = result['data'];
      _listProducts = list.map((model) => Product.fromMap(model)).toList();
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

  List<Iklan> _listIklan = [];

  List<Iklan> get listIklan => _listIklan;

  getIklan() async {
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var param = {'': ''};
    var result = await UserRepository().getAllIklan(param);
    print(result);
    if (result.toString() == '111' || result.toString() == '101') {
      _isLoading = false;
      _connection = false;
      _listIklan = [];
      notifyListeners();
    } else {
      Iterable list = result['data'];
      _listIklan = list.map((model) => Iklan.fromMap(model)).toList();
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

  List<CategioryByToko> _listCategoryByToko = [];

  List<CategioryByToko> get listCategoryByToko => _listCategoryByToko;

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
      _listCategoryByToko = list.map((model) => CategioryByToko.fromMap(model)).toList();
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
      _listRecentProduct = [];
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
    var param = {'id_toko': id_toko.toString(), 'aktif': '1'};
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

  addProduk(List<File> files, body) async {
    _isLoading = true;
    notifyListeners();
    var result = await UserRepository().addProduk(files, body);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == '405') {
      _connection = false;
      _isLoading = false;
      notifyListeners();
      return false;
    } else {
      if (result['meta']['success']) {
        _isLoading = false;
        _connection = true;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        notifyListeners();
        return false;
      }
    }
  }

  Future<bool> updateProduk(List<File> files, body) async {
    _isLoading = true;
    notifyListeners();
    var result = await UserRepository().updateProduk(files, body);
    print(result);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == '405') {
      _connection = false;
      _isLoading = false;
      notifyListeners();
      return false;
    } else {
      if (result['meta']['success']) {
        _isLoading = false;
        _connection = true;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        notifyListeners();
        return false;
      }
    }
  }

  Future<bool> updateStatus(body) async {
    _isLoading = true;
    notifyListeners();
    var result = await UserRepository().updateStatus(body);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == '405') {
      _connection = false;
      _isLoading = false;
      notifyListeners();
      return false;
    } else {
      if (result['meta']['success']) {
        _isLoading = false;
        _connection = true;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        notifyListeners();
        return false;
      }
    }
  }

  String _namaProvinsi = '';
  String _namaKecamatan;
  String _namaKota;

  String get namaProvinsi => _namaProvinsi;

  String get namaKota => _namaKota;

  String get namaKecamatan => _namaKecamatan;

  getCurrentLocation() async {
    String currentIdProvinsi = await LocalStorage.sharedInstance.readValue('idProvinsi');
    if (currentIdProvinsi == null) {
    } else {
      var result = await RajaOngkirRepository().getProvince({'id': currentIdProvinsi.toString()});
      _namaProvinsi = result['rajaongkir']['results']['province'];
      notifyListeners();
      String currentIdKota = await LocalStorage.sharedInstance.readValue('idKota');
      if (currentIdKota != 'null') {
        var param = {'id': currentIdKota.toString()};
        var result = await RajaOngkirRepository().getCity(param);
        _namaKota = result['rajaongkir']['results']['city_name'];
        notifyListeners();
      } else {
        _namaKota = null;
      }
      String currentIdKecamatan = await LocalStorage.sharedInstance.readValue('idKecamatan');
      if (currentIdKecamatan != 'null') {
        var param = {'id': currentIdKota.toString()};
        var result = await RajaOngkirRepository().getSubDistrict(param);
        _namaKecamatan = result['rajaongkir']['results']['subdistrict_name'];
        notifyListeners();
      } else {
        _namaKecamatan = null;
      }
    }
  }
}
