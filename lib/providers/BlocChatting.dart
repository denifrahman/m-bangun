import 'package:apps/Repository/ChatRepository.dart';
import 'package:apps/screen/KonsultasiScreen/data/models/BidangKeahLianModel.dart';
import 'package:flutter/cupertino.dart';

class BlocChatting extends ChangeNotifier {
  bool _isLoading = false;
  bool _connection = true;

  bool get connection => _connection;

  bool get isLoading => _isLoading;

  List<BidangKeahLianModel> _listBidangKeahlian;

  List<BidangKeahLianModel> get listBidangKeahlian => _listBidangKeahlian;

  getBidangKeahlianByParam(param) async {
    _isLoading = true;
    notifyListeners();
    var result = await ChatRepository().getBidangKeahlian(param);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == 'Conncetion Error') {
      _isLoading = false;
      notifyListeners();
      return false;
    } else {
      Iterable list = result['data'];
      _listBidangKeahlian = list.map((model) => BidangKeahLianModel.fromJson(model)).toList();
      _isLoading = false;
      notifyListeners();
      return true;
    }
  }
}
