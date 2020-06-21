import 'dart:convert';

import 'package:apps/Utils/BottomAnimation.dart';
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
  DataProvider() {
    chekSession();
    getToken();
  }

  bool isFavorite = false;
  bool _isLoading = false;
  bool _isLogin = false;

  bool get isLogin => _isLogin;

  bool get isLoading => _isLoading;

  setLoading(bool Boolean) {
    _isLoading = Boolean;
    notifyListeners();
  }

  setLogin(bool Boolean) {
    _isLogin = Boolean;
    notifyListeners();
  }

  String userId;
  String _title;
  String token = '';

  String get getTokenData => token;

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

  void getAllKategori() async {
    Api.getAllKategori(token).then((response) {
      Iterable list = json.decode(response.body)['data'];
      setDataKategori(list.map((e) => KategoriM.fromMap(e)).toList());
    });
  }

  void getToken() async {
    Api.getToken().then((value) {
      var data = json.decode(value.body);
      LocalStorage.sharedInstance.writeValue(key: 'token', value: data['data']['token']);
      getAllKategori();
      notifyListeners();
    });
  }

  chekSession() async {
    token = await LocalStorage.sharedInstance.readValue('token');
    String dataSession = await LocalStorage.sharedInstance.readValue('session');
    if (dataSession != null) {
      userId = json.decode(dataSession)['data']['data_user']['userid'];
      getCurrentLocation();
      _isLogin = true;
      getProfile();
      notifyListeners();
    } else {
      _isLogin = false;
    }
  }

  String _userNama, _userEmail, _userNotelp, _userFoto, _userPengalamanKerja;
  String _fotoNull =
      'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg';

  String get userPengalamanKerja => _userPengalamanKerja;

  String get fotoNull => _fotoNull;

  String get userNama => _userNama;

  String get userEmail => _userEmail;

  String get userNotelp => _userNotelp;

  String get userFoto => _userFoto;

//  void getUserData() async {
//    print(_isLoading);
//    imageCache.clear();
//    String dataSession = await LocalStorage.sharedInstance.readValue('session');
//    _userEmail = json.decode(dataSession)['data']['data_user']['useremail'];
//    _userNama = json.decode(dataSession)['data']['data_user']['usernamalengkap'];
//    _userNotelp = json.decode(dataSession)['data']['data_user']['usertelp'];
//    _userFoto = json.decode(dataSession)['data']['data_user']['userfoto'];
//    _isLoading = false;
//    notifyListeners();
//  }

  String _userSiup, _userAkte, _userKategori, _userSubKategori, _userPremium;
  bool _verified = false;

  String get userSiup => _userSiup;

  String get userAkte => _userAkte;

  String get userKategori => _userKategori;

  String get userSubKategori => _userSubKategori;

  String get userPremium => _userPremium;

  bool get verified => _verified;

  getProfile() async {
    try {
      imageCache.clear();
      Api.getUserById(token, userId).then((response) {
        var data = json.decode(response.body);
        LocalStorage.sharedInstance.writeValue(key: 'session', value: json.encode(data));
        print(data['data']['data_user']['useraktivasiakunpremium']);
        if (data['data']['data_user']['produkkategoriid'] != null) {
          _userSiup = data['data']['data_user']['usersiup'];
          _userAkte = data['data']['data_user']['userakteperusahaan'];
          _userKategori = data['data']['data_user']['produkkategorinama'];
          _userSubKategori = data['data']['data_user']['produkkategorisubnama'];
          _userEmail = data['data']['data_user']['useremail'];
          _userNama = data['data']['data_user']['usernamalengkap'];
          _userNotelp = data['data']['data_user']['usertelp'];
          _userFoto = data['data']['data_user']['userfoto'];
          _userPengalamanKerja = data['data']['data_user']['userpengalamankerja'];
          _isLoading = false;
          notifyListeners();
        }
        if (data['data']['data_user']['useraktivasiakunpremium'] != '0') {
          _verified = true;
          _isLoading = false;
          notifyListeners();
        } else {
          _verified = false;
          _isLoading = false;
          notifyListeners();
        }
      });
    } catch (err) {
      print(err);
    }
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
  String key = '';

  String get keySearch => key;

  setKeySearch(String query) {
    notifyListeners();
    if (query.isEmpty) {
      dataProdukListByParam = [];
      key = '';
      notifyListeners();
    } else {
      setProdukListByParam();
      notifyListeners();
    }
  }

  String idSubKategori = '';

  setidSubKategori(String id) {
    idSubKategori = id;
    notifyListeners();
  }

  List<ProdukListM> dataProdukListByParam = [];

  bool get getReloadProduk => _reload;

  List<ProdukListM> get getProdukListByParam => dataProdukListByParam;

  setProdukListByParam() async {
    imageCache.clear();
    String currentIdProvinsi = await LocalStorage.sharedInstance.readValue('idProvinsi');
    String currentIdKota = await LocalStorage.sharedInstance.readValue('idKota');
    String currentIdKecamatan = await LocalStorage.sharedInstance.readValue('idKecamatan');
    bool responsData = true;
    Api.getAllProdukByParam(token, currentIdKecamatan == 'null' ? '' : currentIdKecamatan, currentIdKota == 'null' ? '' : currentIdKota,
            currentIdProvinsi == 'null' ? '' : currentIdProvinsi, idSubKategori, key)
        .then((response) {
      var result = json.decode(response.body);
      if (result['status'] == true) {
        responsData = true;
        Iterable list = json.decode(response.body)['data'];
        dataProdukListByParam = list.map((model) => ProdukListM.fromMap(model)).toList();
        notifyListeners();
      }
    });
  }

  String _namaProvinsi, _namaKecamatan, _namaKota;

  String get namaProvinsi => _namaProvinsi;

  String get namaKota => _namaKota;

  String get namaKecamatan => _namaKecamatan;

  getCurrentLocation() async {
    String currentIdProvinsi = await LocalStorage.sharedInstance.readValue('idProvinsi');
    print(currentIdProvinsi);
    if (currentIdProvinsi == null) {
      print(currentIdProvinsi);
    } else {
      Api.getProvinsiById(token, currentIdProvinsi).then((value) {
        var result = json.decode(value.body);
        _namaProvinsi = result['data']['nama_propinsi'];
        notifyListeners();
      });
      String currentIdKota = await LocalStorage.sharedInstance.readValue('idKota');
      if (currentIdKota != 'null') {
        Api.getKotaById(token, currentIdKota).then((value) {
          var result = json.decode(value.body);
          _namaKota = result['data']['nama_kabkota'];
          notifyListeners();
        });
      } else {
        _namaKota = null;
      }
      String currentIdKecamatan = await LocalStorage.sharedInstance.readValue('idKecamatan');
      if (currentIdKecamatan != 'null') {
        Api.getKecamatanById(token, currentIdKecamatan).then((value) {
          var result = json.decode(value.body);
          _namaKecamatan = result['data']['nama_kecamatan'];
          notifyListeners();
        });
      } else {
        _namaKecamatan = null;
      }
    }
  }

  Map<String, dynamic> dataProdukById;

  Map<String, dynamic> get getdataProdukById => dataProdukById;

  getProdukById(String produkId) {
    _isLoading = true;
    notifyListeners();
    Api.getProdukByIdProduk(token, produkId).then((value) {
      var result = json.decode(value.body);
      print(result);
      if (result['status']) {
        if (userId != null) {
          getFavoriteByProdukIdAndUserId(produkId);
          _isLoading = false;
          notifyListeners();
        }
        _isLoading = false;
        dataProdukById = result;
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
      }
    });
  }

  bool get favoriteProduk => isFavorite;

  getFavoriteByProdukIdAndUserId(produkId) {
    Api.getFavoriteByProdukIdAndUserId(token, produkId, userId).then((value) {
      var result = json.decode(value.body);
      if (result['data'].length == 1) {
        isFavorite = true;
        _isLoading = false;
        notifyListeners();
      } else {
        isFavorite = false;
        _isLoading = false;
        notifyListeners();
      }
      notifyListeners();
    });
  }

  setFavoriveByUserId(produkId) {
    var map = new Map<String, dynamic>();
    map['userid'] = userId;
    map['produkid'] = produkId;
    Api.createFavoriteByUserId(token, map).then((value) {
      var result = json.decode(value.body);
      if (result['status']) {
        isFavorite = !isFavorite;
        getFavoriteByProdukIdAndUserId(produkId);
        notifyListeners();
      }
    });
  }

  deleteFavoriteByUserId(produkId) {
    var map = new Map<String, dynamic>();
    map['userid'] = userId;
    map['produkid'] = produkId;
    Api.deleteFavoriteByUserIdAndProdukId(token, map).then((value) {
      var result = json.decode(value.body);
      if (result['status']) {
        isFavorite = !isFavorite;
        getFavoriteByProdukIdAndUserId(produkId);
        notifyListeners();
      }
    });
  }

  void logout(context) {
    LocalStorage.sharedInstance.deleteValue('session');
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
          return BottomAnimateBar();
        }, transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
          return new SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }),
            (Route route) => false);
    chekSession();
  }
}
