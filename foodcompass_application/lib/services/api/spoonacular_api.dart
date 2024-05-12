// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'package:dio/dio.dart';
import 'package:foodcompass_application/models/detail_model.dart';
import 'package:foodcompass_application/models/detail_nutrition_model.dart';
import 'package:foodcompass_application/models/detail_similar_food_model.dart';
import 'package:foodcompass_application/models/failure_model.dart';
import 'package:foodcompass_application/models/food_model.dart';
import 'package:foodcompass_application/models/search_model.dart';
import 'package:foodcompass_application/utils/base_url_utils.dart';

class SpoonacularApi {
  var key = 'f629397efe344854997c03fc05b4a90a';
  final dio = Dio();

  Future<FoodList> getRecipe(String type, int number) async {
    try {
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
        throw FailureMessage(
            code: response.statusCode!, message: response.statusMessage!);
      }
    } catch (e) {
      print('Error fetching recipe: $e');
      throw FailureMessage(code: 500, message: 'Something went wrong');
    }
  }

  Future<FoodList> getRandom(int number) async {
    try {
      var url = BaseUrl.baseUrl + "/random?number=$number" + '&apiKey=' + key;

      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return FoodList.fromJson(response.data['recipes']);
      } else if (response.statusCode == 401) {
        throw FailureMessage(code: 401, message: response.data['message']);
      } else {
        throw FailureMessage(
            code: response.statusCode!, message: response.statusMessage!);
      }
    } catch (e) {
      print('Error fetching recipe: $e');
      throw FailureMessage(code: 500, message: 'Something went wrong');
    }
  }

  Future<DetailRecipeModel> getDetailRecipe(String id) async {
    try {
      var url =
          BaseUrl.baseUrl + id + BaseUrl.informationPath + 'apiKey=' + key;
      print(url);
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return DetailRecipeModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw FailureMessage(code: 401, message: response.data['message']);
      } else {
        throw FailureMessage(
            code: response.statusCode!, message: response.statusMessage!);
      }
    } catch (e) {
      print('Error fetching detail recipe: $e');
      throw FailureMessage(code: 500, message: 'Something went wrong');
    }
  }

  Future<DetailNutritionModel> getDetailNutrition(String id) async {
    try {
      var url = BaseUrl.baseUrl + id + BaseUrl.nutritionPath + 'apiKey=' + key;
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return DetailNutritionModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw FailureMessage(code: 401, message: response.data['message']);
      } else {
        throw FailureMessage(
            code: response.statusCode!, message: response.statusMessage!);
      }
    } catch (e) {
      print('Error fetching detail nutrition: $e');
      throw FailureMessage(code: 500, message: 'Something went wrong');
    }
  }

  Future<SimilarFoodList> getSimilarFood(String id) async {
    try {
      var url = BaseUrl.baseUrl + id + BaseUrl.similarPath + 'apiKey=' + key;
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return SimilarFoodList.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw FailureMessage(code: 401, message: response.data['message']);
      } else {
        throw FailureMessage(
            code: response.statusCode!, message: response.statusMessage!);
      }
    } catch (e) {
      print('Error fetching similar food: $e');
      throw FailureMessage(code: 500, message: 'Something went wrong');
    }
  }

  Future<SearchModel> getSearch(String type, int number) async {
    try {
      var url = BaseUrl.baseUrl +
          "/complexSearch?query=$type&number=$number" +
          '&apiKey=' +
          key;

      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return SearchModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw FailureMessage(code: 401, message: response.data['message']);
      } else {
        throw FailureMessage(
            code: response.statusCode!, message: response.statusMessage!);
      }
    } catch (e) {
      print('Error fetching search: $e');
      throw FailureMessage(code: 500, message: 'Something went wrong');
    }
  }
}
