import 'package:dio/dio.dart';
import 'package:foodcompass_application/models/detail_model.dart';
import 'package:foodcompass_application/models/failure_model.dart';

class GetInformation {
  var key = 'f629397efe344854997c03fc05b4a90a';
  final dio = Dio();

  Future<DetailRecipeModel> getDetailRecipe (String id) async {
    var url = 'https://api.spoonacular.com/recipes/$id/information?apiKey=$key';

    final response = await dio.get(url);
    if (response.statusCode == 200) {
      return DetailRecipeModel.fromJson(response.data);
    } else if (response.statusCode == 401) {
      throw FailureMessage(code: 401, message: response.data['message']);
    } else {
      print(response.statusCode);
      throw FailureMessage(
          code: response.statusCode!, message: response.statusMessage!);
    }
  }
}