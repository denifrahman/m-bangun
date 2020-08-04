import 'package:apps/Api/ApiBaseHelper.dart';

class UserRepository {
  final String _apiKey = "Paste your api key here";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future getUserByParam(param) async {
    final response = await _helper.get("user/getAllByParam", param);
    return response;
  }

  Future create(body) async {
    final response = await _helper.post("user/insert", body);
    return response;
  }

  Future getOfficialStore(param) async {
    final response = await _helper.get("toko/getOfficialStore", param);
    return response;
  }

  Future getDetailStore(param) async {
    final response = await _helper.get("toko/getAllByParam", param);
    return response;
  }

  Future getCategory(param) async {
    final response = await _helper.get("kategori/getAllByParam", param);
    return response;
  }

  Future getCategoryByToko(param) async {
    final response = await _helper.get("kategori/getKategoriByToko", param);
    return response;
  }

  Future getRecentProduct(param) async {
    final response = await _helper.get("produk/getRecentProduk", param);
    return response;
  }

  Future getAllProduct(param) async {
    final response = await _helper.get("produk/getAllByParam", param);
    return response;
  }

  Future getProdukTerjual(param) async {
    final response = await _helper.get("produk/getProdukTerjual", param);
    return response;
  }

  Future createShippingAddress(body) async {
    final response = await _helper.post("user/insertAlamat", body);
    return response;
  }

  Future getUserAddress(param) async {
    final response = await _helper.get("user/getAllAlamatByParam", param);
    return response;
  }
}
