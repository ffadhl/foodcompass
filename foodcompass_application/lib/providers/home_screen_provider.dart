// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:foodcompass_application/models/failure_model.dart';
import 'package:foodcompass_application/models/food_model_home_screen_model.dart';
import 'package:foodcompass_application/models/search_model.dart';
import 'package:foodcompass_application/services/api/spoonacular_api.dart';

class HomeScreenProvider extends ChangeNotifier {
  FoodList? _breakfastRecipes;
  FoodList? _lunchRecipes;
  FoodList? _drinkRecipes;

  FoodList? get breakfastRecipes => _breakfastRecipes;
  FoodList? get lunchRecipes => _lunchRecipes;
  FoodList? get drinkRecipes => _drinkRecipes;

  bool get isLoading =>
      _breakfastRecipes == null ||
      _lunchRecipes == null ||
      _drinkRecipes == null;

  Future<void> fetchRecipes() async {
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

  List<Result> _searchResults = [];
  bool _isLoadingSearch = false;
  bool _isSearched = false;

  bool get isLoadingSearch => _isLoadingSearch;
  bool get isSearched => _isSearched;
  List<Result> get searchResults => _searchResults;

  Future<void> performSearch(String query) async {
    _isLoadingSearch = true;
    notifyListeners();

    try {
      final searchResults = await SpoonacularApi().getSearch(query, 25);
      _searchResults = searchResults.results;
      _isSearched = true;
    } on FailureMessage catch (e) {
      print(e.message);
    } catch (e) {
      print('Error performing search: $e');
    } finally {
      _isLoadingSearch = false;
      notifyListeners();
    }
  }

  void resetState() {
    _isLoadingSearch = false;
    _isSearched = false;
    _searchResults = [];
    notifyListeners();
  }
}
