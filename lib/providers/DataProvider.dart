import 'dart:convert';

import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/KategoriM.dart';
import 'package:apps/models/KecamatanM.dart';
import 'package:apps/models/KotaM.dart';
import 'package:apps/models/ProdukListM.dart';
import 'package:apps/models/ProvinsiM.dart';
import 'package:apps/models/SubKategoriM.dart';
import 'package:apps/providers/Api.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  String _title;

  String get getTitle => this._title;

  List<ProdukListM> _produkListById = [];

  List<ProdukListM> get getProdukListByIdUser => this._produkListById;

  setProdukListById(List<ProdukListM> param) {
    this._produkListById = param;
    notifyListeners();
  }

  setTitle(String param) {
    this._title = param;
    notifyListeners();
  }

  List<KategoriM> _dataKategori = [];

  List<KategoriM> get getDataKategori => _dataKategori;

  setDataKategori(List<KategoriM> data) {
    _dataKategori = data;
    notifyListeners();
  }

  String _selectedKategori = null;

  String get getSelectedKategori => _selectedKategori;

  setSelectedKategori(String data) {
    _selectedKategori = data;
    notifyListeners();
  }

  List<SubKategoriM> _dataSubKategori = [];

  List<SubKategoriM> get getDataSubKategori => _dataSubKategori;

  setDataSubKategori(List<SubKategoriM> data) {
    _dataSubKategori = data;
    notifyListeners();
  }

  String _selectedSubKategori = null;

  String get getSelectedSubKategori => _selectedSubKategori;

  setSelectedSubKategori(String data) {
    _selectedSubKategori = data;
    notifyListeners();
  }

  List<ProvinsiM> _dataProvinsi = [];

  List<ProvinsiM> get getDataProvinsi => _dataProvinsi;

  setDataProvinsi(List<ProvinsiM> data) {
    _dataProvinsi = data;
    notifyListeners();
  }

  String _selectedProvinsi = null;

  String get getSelectedProvinsi => _selectedProvinsi;

  setSelectedProvinsi(String data) {
    _selectedProvinsi = data;
    notifyListeners();
  }

  List<KotaM> _dataKota = [];

  List<KotaM> get getDataKota => _dataKota;

  setDataKota(List<KotaM> data) {
    _dataKota = data;
    notifyListeners();
  }

  String _selectedKota = null;

  String get getSelectedKota => _selectedKota;

  setSelectedKota(String data) {
    _selectedKota = data;
    notifyListeners();
  }

  List<KecamatanM> _dataKecamatan = [];

  List<KecamatanM> get getDataKecamatan => _dataKecamatan;

  setDataKecamatan(List<KecamatanM> data) {
    _dataKecamatan = data;
    notifyListeners();
  }

  String _selectedKecamatan = null;

  String get getSelectedKecamatan => _selectedKecamatan;

  setSelectedKecamatan(String data) {
    _selectedKecamatan = data;
    notifyListeners();
  }

  String _alamatLengkap;

  String get getAlamatLengkap => _alamatLengkap;

  setAlamatLengkap(String alamat) {
    _alamatLengkap = alamat;
    notifyListeners();
  }

  bool _reload = false;
  List<ProdukListM> dataProdukListByParam = [];
  String key = '';

  String idSubKategori = '';

  setidSubKategori(String id) {
    idSubKategori = id;
    notifyListeners();
  }

  bool get getReloadProduk => _reload;

  List<ProdukListM> get getProdukListByParam => dataProdukListByParam;

  setProdukListByParam() async {
//    _reload = param;
    String token = await LocalStorage.sharedInstance.readValue('token');
    String currentIdProvinsi = await LocalStorage.sharedInstance.readValue('idProvinsi');
    String currentIdKota = await LocalStorage.sharedInstance.readValue('idKota');
    String currentIdKecamatan = await LocalStorage.sharedInstance.readValue('idKecamatan');
    bool responsData = true;
    Api.getAllProdukByParam(token, currentIdKecamatan == 'null' ? '' : currentIdKecamatan, currentIdKota == 'null' ? '' : currentIdKota,
            currentIdProvinsi == 'null' ? '' : currentIdProvinsi, idSubKategori, key)
        .then((response) {
      var data = json.decode(response.body);
      if (data['status'] == true) {
        responsData = true;
        Iterable list = json.decode(response.body)['data'];
        dataProdukListByParam = list.map((model) => ProdukListM.fromMap(model)).toList();
        notifyListeners();
      }
    });
  }
}
