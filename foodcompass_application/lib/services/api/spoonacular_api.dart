// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'package:dio/dio.dart';
import 'package:foodcompass_application/models/failure_model.dart';
import 'package:foodcompass_application/models/food_model_home_screen_model.dart';
import 'package:foodcompass_application/utils/base_url_utils.dart';

class SpoonacularApi {
  var key = 'f629397efe344854997c03fc05b4a90a';
  final dio = Dio();

  Future<FoodList> getRecipe(String type, int number) async {
    var url = BaseUrl.baseUrl +
        "/random?number=$number&tags=$type" +
        '&apiKey=' +
        key;

    final response = await dio.get(url);
    if (response.statusCode == 200) {
      return FoodList.fromJson(response.data['recipes']);
    } else if (response.statusCode == 401) {
      throw FailureMessage(code: 401, message: response.data['message']);
    } else {
      print(response.statusCode);
      throw FailureMessage(
          code: response.statusCode!, message: response.statusMessage!);
    }
  }
}
