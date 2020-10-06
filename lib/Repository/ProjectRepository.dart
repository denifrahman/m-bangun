import 'dart:io';

import 'package:apps/Api/ApiBaseHelper.dart';

class ProjectRepository {
  final String _apiKey = "Paste your api key here";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future getAllProductByParam(param) async {
    final response = await _helper.get("project/getAllByParam", param);
    return response;
  }

  Future getTagihanByParam(param) async {
    final response = await _helper.get("tagihan/getAllByParam", param);
    return response;
  }

  Future updateStatus(param) async {
    final response = await _helper.post("project/update", param);
    return response;
  }

  Future uploadTermin(List<File> files, body) async {
    final response = await _helper.multipart("tagihan/update", files, body);
    return response;
  }
}
