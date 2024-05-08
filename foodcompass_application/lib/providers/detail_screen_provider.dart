import 'package:flutter/material.dart';
import 'package:foodcompass_application/models/detail_model.dart';
import 'package:foodcompass_application/models/detail_nutrition_model.dart';
import 'package:foodcompass_application/models/detail_similar_food_model.dart';
import 'package:foodcompass_application/models/failure_model.dart';
import 'package:foodcompass_application/services/api/spoonacular_api.dart';

class DetailScreenProvider extends ChangeNotifier {
  DetailRecipeModel? _detailRecipeModel;
  DetailNutritionModel? _detailNutritionModel;
  SimilarFoodList? _similarFoodList;
  bool _isLoading = false;

  DetailRecipeModel? get detailRecipeModel => _detailRecipeModel;
  DetailNutritionModel? get detailNutritionModel => _detailNutritionModel;
  SimilarFoodList? get similarFoodList => _similarFoodList;
  bool get isLoading => _isLoading;

  void getDetailRecipe(String id) async {
    _isLoading = true;
    _detailRecipeModel = null;
    _detailNutritionModel = null;
    notifyListeners();
    try {
      final getInformation = SpoonacularApi();
      _detailRecipeModel = await getInformation.getDetailRecipe(id);
      _detailNutritionModel = await getInformation.getDetailNutrition(id);
      _similarFoodList = await getInformation.getSimilarFood(id);
      notifyListeners();
    } on FailureMessage catch (e) {
      print(e.message);
    } catch (e) {
      print(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
