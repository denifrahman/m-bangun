import 'package:apps/Repository/RajaOngkirRepository.dart';
import 'package:apps/Repository/UserRepository.dart';
import 'package:apps/models/City.dart';
import 'package:apps/models/Provice.dart';
import 'package:apps/models/SubDistricById.dart';
import 'package:apps/models/SubDistrict.dart';
import 'package:apps/models/UserAddress.dart';
import 'package:flutter/material.dart';

class BlocProfile extends ChangeNotifier {
  BlocProfile() {
    getProvince();
  }

  getProfileUser(id) async {
    var param = {'id': id.toString()};
    var result = await UserRepository().getUserByParam(param);
  }

  String _id_provice, _id_city, _id_subdistrict;
  bool _isLoading = false;

  String get id_provice => _id_provice;

  String get id_city => _id_city;

  String get id_subdistrict => _id_subdistrict;

  bool get isLoading => _isLoading;

  setIdProvince(String value) {
    _id_provice = value;
    _listSubDistrict = [];
    _id_city = null;
    _id_subdistrict = null;
    getCity();
    notifyListeners();
  }

  setIdCity(String value) {
    _id_city = value;
    _id_subdistrict = null;
    getSubDistrict();
    notifyListeners();
  }

  setIdSubistrict(String value) {
    _id_subdistrict = value;
    notifyListeners();
  }

  clearDataCity() {
    _listCity = [];
    _listProvince = [];
    _listSubDistrict = [];
    _id_city = null;
    _id_provice = null;
    _id_subdistrict = null;
    getProvince();
    notifyListeners();
  }

  List<Provice> _listProvince = [];

  List<Provice> get listProvice => _listProvince;

  getProvince() async {
    _isLoading = true;
    notifyListeners();
    var param = {'': ''};
    var result = await RajaOngkirRepository().getProvince(param);
    Iterable list = [result];
    _listProvince = list.map((model) => Provice.fromMap(model)).toList();
    _isLoading = false;
    notifyListeners();
  }

  List<City> _listCity = [];

  List<City> get listCity => _listCity;

  getCity() async {
    _isLoading = true;
    notifyListeners();
    var param = {'province': _id_provice.toString()};
    var result = await RajaOngkirRepository().getCity(param);
    Iterable list = [result];
    _listCity = list.map((model) => City.fromMap(model)).toList();
    _isLoading = false;
    notifyListeners();
  }

  List<SubDistrict> _listSubDistrict = [];

  List<SubDistrict> get listSubDistrict => _listSubDistrict;

  getSubDistrict() async {
    _isLoading = true;
    notifyListeners();
    var param = {'city': _id_city.toString()};
    var result = await RajaOngkirRepository().getSubDistrict(param);
    print(result);
    Iterable list = [result];
    _listSubDistrict = list.map((model) => SubDistrict.fromMap(model)).toList();
    _isLoading = false;
    notifyListeners();
  }

  List<SubDistricById> _listSubDistrictById = [];

  List<SubDistricById> get listSubDistrictById => _listSubDistrictById;

  getSubDistrictById(id) async {
    _isLoading = true;
    notifyListeners();
    var param = {'id': id.toString()};
    var result = await RajaOngkirRepository().getSubDistrict(param);
    Iterable list = [result['rajaongkir']['results']];
    _listSubDistrictById = list.map((model) => SubDistricById.fromMap(model)).toList();
    _id_provice = _listSubDistrictById[0].provinceId;
    _id_city = _listSubDistrictById[0].cityId;
    _id_subdistrict = _listSubDistrictById[0].subdistrictId;
    getProvince();
    getCity();
    getSubDistrict();
    _isLoading = false;
    notifyListeners();
  }

  List<UserAddress> _listUserAddress = [];

  List<UserAddress> get listUserAddress => _listUserAddress;

  getAllUserAddress(id_user) async {
    _isLoading = true;
    notifyListeners();
    var param = {'id_user': id_user.toString()};
    var result = await UserRepository().getUserAddress(param);
    Iterable list = result['data'];
    _listUserAddress = list.map((model) => UserAddress.fromMap(model)).toList();
    getSubDistrictById(_listUserAddress[0].idKecamatan);
    _isLoading = false;
    notifyListeners();
  }

  getUserAddressById(id) async {
    _isLoading = true;
    notifyListeners();
    var param = {'id': id.toString()};
    var result = await UserRepository().getUserAddress(param);
    Iterable list = result['data'];
    _listUserAddress = list.map((model) => UserAddress.fromMap(model)).toList();
    _isLoading = false;
    notifyListeners();
  }

  List<UserAddress> _listUserAddressDefault = [];

  List<UserAddress> get listUserAddressDefault => _listUserAddressDefault;

  getUserAddressDefault() async {
    _isLoading = true;
    notifyListeners();
    var param = {'default': "1"};
    var result = await UserRepository().getUserAddress(param);
    Iterable list = result['data'];
    _listUserAddressDefault = list.map((model) => UserAddress.fromMap(model)).toList();
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> createShippingAddress(body) async {
    _isLoading = true;
    notifyListeners();
    var result = await UserRepository().createShippingAddress(body);
    if (result['meta']['success']) {
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      notifyListeners();
      return result;
    }
  }

  Future<bool> updateShippingAddress(body) async {
    _isLoading = true;
    notifyListeners();
    var result = await UserRepository().updateShippingAddress(body);
    if (result['meta']['success']) {
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> setDefaultAlamat(body) async {
    _isLoading = true;
    notifyListeners();
    var result = await UserRepository().setDefaultAlamat(body);
    if (result['meta']['success']) {
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
