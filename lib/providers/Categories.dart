import 'package:apps/Repository/CategoryRepository.dart';
import 'package:apps/models/Categories.dart';
import 'package:apps/screen/TopCardMenu/data/models/HeaderMenuModel.dart';
import 'package:flutter/material.dart';

class BlogCategories extends ChangeNotifier {
  BlogCategories() {
    getListDataHeaderMenu({'aktif': '1'});
  }

  bool _isLoading = false;

  bool _connection = false;

  bool get connection => _connection;

  bool get isLoading => _isLoading;
  List<Categories> _dataKategoriHome = [];

  List<Categories> get dataKategoriHome => _dataKategoriHome;

  List<HeaderMenuModel> _listDataHeaderMenu = [];

  List<HeaderMenuModel> get listDataHeaderMenu => _listDataHeaderMenu;

  Future getListDataHeaderMenu(param) async {
    var result = await CategoryRepository().getHeaderMenuCategory(param);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == '405' || result.toString() == 'Conncetion Error') {
      _connection = false;
      _isLoading = false;
      notifyListeners();
      return result;
    } else {
      if (result['meta']['success']) {
        Iterable list = result['data'];
        _listDataHeaderMenu = list.map((model) => HeaderMenuModel.fromJson(model)).toList();
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
      }
    }
  }
}
