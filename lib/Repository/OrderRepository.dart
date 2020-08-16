import 'package:apps/Api/ApiBaseHelper.dart';
import 'package:apps/Api/ApiOrderJson.dart';

class OrderRepository {
  final String _apiKey = "Paste your api key here";

  ApiBaseHelper _helper = ApiBaseHelper();
  ApiOrderJson _helperOrderJson = ApiOrderJson();

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

  Future updateOrder(body) async {
    final response = await _helper.post("order/updateStatus", body);
    return response;
  }

  Future getMetodePembayaran(param) async {
    final response = await _helper.get("order/getMetodePembayaran", param);
    return response;
  }

  Future getCost(param) async {
    final response = await _helper.get("ongkir/getBiayaOngkir", param);
    return response;
  }

  Future getOrderByParam(param) async {
    final response = await _helper.get("order/getOrderByParam", param);
    return response;
  }

  Future getOrderProdukByParam(param) async {
    final response = await _helper.get("order/getOrderProdukByParam", param);
    return response;
  }

  Future getUlasanProdukByParam(param) async {
    final response = await _helper.get("order/getUlasanByParam", param);
    return response;
  }

  Future insert(body) async {
    final response = await _helperOrderJson.post("order/insert", body);
    return response;
  }

  Future insertUlasan(body) async {
    final response = await _helper.post("order/insertUlasan", body);
    return response;
  }
}
