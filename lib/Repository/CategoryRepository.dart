import 'package:apps/Api/ApiBaseHelper.dart';
import 'package:apps/Api/ApiBaseHelperMidtrans.dart';
import 'package:apps/Api/ApiOrderJson.dart';

class CategoryRepository {
  final String _apiKey = "Paste your api key here";

  ApiBaseHelper _helper = ApiBaseHelper();
  ApiBaseHelperMidtrans _helperMidtrans = ApiBaseHelperMidtrans();
  ApiOrderJson _helperOrderJson = ApiOrderJson();

  Future getHeaderMenuCategory(param) async {
    final response = await _helper.get("HeaderKategori/getAllByParam", param);
    return response;
  }

}
