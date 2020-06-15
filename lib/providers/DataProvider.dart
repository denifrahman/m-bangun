import 'package:apps/models/KategoriM.dart';
import 'package:apps/models/KecamatanM.dart';
import 'package:apps/models/KotaM.dart';
import 'package:apps/models/ProdukListM.dart';
import 'package:apps/models/ProvinsiM.dart';
import 'package:apps/models/SubKategoriM.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  List<ProdukListM> _produkListM = [];
  String _title;

  List<ProdukListM> get getProduk => this._produkListM;

  String get getTitle => this._title;

  setTempDataprovince(List<ProdukListM> param) {
    this._produkListM = param;
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
}
