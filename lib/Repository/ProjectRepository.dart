import 'package:apps/Api/ApiBaseHelper.dart';

class ProjectRepository {
  final String _apiKey = "Paste your api key here";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future getAllProductByParam(param) async {
    final response = await _helper.get("project/getAllByParam", param);
    return response;
  }
}
