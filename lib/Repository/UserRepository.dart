import 'dart:io';

import 'package:apps/Api/ApiBaseHelper.dart';

class UserRepository {
  final String _apiKey = "Paste your api key here";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future getUserByParam(param) async {
    final response = await _helper.get("user/getAllByParam", param);
    return response;
  }

  Future getMitraByParam(param) async {
    final response = await _helper.get("user/getAllMitraByParam", param);
    return response;
  }

  Future getJenisLayananByParam(param) async {
    final response = await _helper.get("JenisLayanan/getAllByParam", param);
    return response;
  }

  Future create(body) async {
    final response = await _helper.post("user/insert", body);
    return response;
  }

  Future update(body) async {
    final response = await _helper.post("user/updateProfileUser", body);
    return response;
  }

  Future getOfficialStore(param) async {
    final response = await _helper.get("toko/getOfficialStore", param);
    return response;
  }

  Future getIklanTokoLink(param) async {
    final response = await _helper.get("toko/getIklanTokoLink", param);
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

  Future getFavoriteProduct(param) async {
    final response = await _helper.get("produk/getFavoriteByParam", param);
    return response;
  }

  Future getAllIklan(param) async {
    final response = await _helper.get("iklan/getAllByParam", param);
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

  Future updateShippingAddress(body) async {
    final response = await _helper.post("user/updateAlamat", body);
    return response;
  }

  Future getUserAddress(param) async {
    final response = await _helper.get("user/getAllAlamatByParam", param);
    return response;
  }

  Future getTokoByParam(param) async {
    final response = await _helper.get("toko/getAllByParam", param);
    return response;
  }

  Future getPenghasilanByParam(param) async {
    final response = await _helper.get("penghasilan/getAllByParam", param);
    return response;
  }

  Future setDefaultAlamat(body) async {
    final response = await _helper.post("user/updateDefaultAlamat", body);
    return response;
  }

  Future addCountViewProduk(body) async {
    final response = await _helper.post("produk/insertDilihat", body);
    return response;
  }

  Future addProduk(List<File> files, body) async {
    final response = await _helper.multipart("produk/insert", files, body);
    return response;
  }

  Future updateProduk(List<File> files, body) async {
    final response = await _helper.multipart("produk/update", files, body);
    return response;
  }

  Future updateToko(List<File> files, body) async {
    final response = await _helper.multipart("toko/update", files, body);
    return response;
  }

  Future updateStatus(body) async {
    final response = await _helper.post("produk/update", body);
    return response;
  }
}
