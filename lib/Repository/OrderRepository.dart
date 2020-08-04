import 'package:apps/Api/ApiBaseHelper.dart';

class OrderRepository {
  final String _apiKey = "Paste your api key here";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future getCart(param) async {
    final response = await _helper.get("order/getCartGroupByToko", param);
    return response;
  }

  Future addToCart(body) async {
    final response = await _helper.post("order/addToCart", body);
    return response;
  }

  Future removeCart(body) async {
    final response = await _helper.post("order/delete", body);
    return response;
  }

  Future updateCart(body) async {
    final response = await _helper.post("order/update", body);
    return response;
  }
}
