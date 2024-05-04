// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:foodcompass_application/models/failure_model.dart';
import 'package:foodcompass_application/models/food_model_home_screen_model.dart';
import 'package:foodcompass_application/services/api/spoonacular_api.dart';

class HomeScreenProvider extends ChangeNotifier {
  FoodList? _breakfastRecipes;
  FoodList? _lunchRecipes;
  FoodList? _drinkRecipes;

  FoodList? get breakfastRecipes => _breakfastRecipes;
  FoodList? get lunchRecipes => _lunchRecipes;
  FoodList? get drinkRecipes => _drinkRecipes;

  bool get isLoading =>
      _breakfastRecipes == null || _lunchRecipes == null || _drinkRecipes == null;

  Future <void> fetchRecipes() async {
    final spoonacularApi = SpoonacularApi();
    try {
      _breakfastRecipes ??= await spoonacularApi.getRecipe("breakfast", 20);
      _lunchRecipes ??= await spoonacularApi.getRecipe("lunch", 20);
      _drinkRecipes ??= await spoonacularApi.getRecipe("drink", 20);
      notifyListeners();
    } on FailureMessage catch (e) {
      print(e.message);
    } catch (e) {
      print(e.toString());
    }
  }
}
