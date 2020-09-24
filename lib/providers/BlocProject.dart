import 'package:apps/Repository/OrderRepository.dart';
import 'package:apps/Repository/ProjectRepository.dart';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/Bids.dart';
import 'package:apps/models/Project.dart';
import 'package:flutter/cupertino.dart';

class BlocProject extends ChangeNotifier {
  BlocProject() {}

  bool _isLoading = false;
  bool _connection = false;

  bool get connection => _connection;

  bool get isLoading => _isLoading;
  List<Project> _listProjects = [];

  List<Project> get listProjects => _listProjects;

  getProjectByParam(param) async {
    var result = await ProjectRepository().getAllProductByParam(param);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == '8') {
      _connection = false;
      _isLoading = false;
      _listProjects = [];
      notifyListeners();
    } else {
      Iterable list = result['data'];
      _listProjects = list.map((model) => Project.fromMap(model)).toList();
      _isLoading = false;
      _connection = true;
      notifyListeners();
    }
  }

  List<Project> _listProjectDetail = [];

  List<Project> get listProjectDetail => _listProjectDetail;

  Future<bool> getProjectByOrder(param) async {
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var result = await OrderRepository().getProjectByOrder(param);
    if (result['meta']['success']) {
      _isLoading = false;
      Iterable list = result['data'];
      _listProjectDetail = list.map((model) => Project.fromMap(model)).toList();
      var id = await LocalStorage.sharedInstance.readValue('id_user_login');
      getBidsByParam({"id_projek": result['data'][0]['id'].toString(), 'id_user': id.toString()});
      notifyListeners();
      return true;
    } else {
      _listProjectDetail = [];
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateSelectedBid(body) async {
    imageCache.clear();
    var result = await OrderRepository().updateSelectedBid(body);
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

  List<Bids> _listBids = [];

  List<Bids> get listBids => _listBids;

  Future<bool> getBidsByParam(param) async {
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var result = await OrderRepository().getBidsByParam(param);
    if (result['meta']['success']) {
      _isLoading = false;
      Iterable list = result['data'];
      _listBids = list.map((model) => Bids.fromMap(model)).toList();
      notifyListeners();
      return true;
    } else {
      _listBids = [];
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  createSignature(body) async {
    var result = await OrderRepository().createSignature(body);
  }
}
