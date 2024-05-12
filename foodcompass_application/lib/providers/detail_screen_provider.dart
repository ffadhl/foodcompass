// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:foodcompass_application/helpers/database_helper.dart';
import 'package:foodcompass_application/models/detail_model.dart';
import 'package:foodcompass_application/models/detail_nutrition_model.dart';
import 'package:foodcompass_application/models/detail_similar_food_model.dart';
import 'package:foodcompass_application/models/failure_model.dart';
import 'package:foodcompass_application/models/favorite_model.dart';
import 'package:foodcompass_application/services/api/spoonacular_api.dart';
import 'package:provider/provider.dart';

class DetailScreenProvider extends ChangeNotifier {
  DetailRecipeModel? _detailRecipeModel;
  DetailNutritionModel? _detailNutritionModel;
  SimilarFoodList? _similarFoodList;
  bool _isLoading = false;
  late bool _isFavorite = false;

  DetailRecipeModel? get detailRecipeModel => _detailRecipeModel;
  DetailNutritionModel? get detailNutritionModel => _detailNutritionModel;
  SimilarFoodList? get similarFoodList => _similarFoodList;
  bool get isLoading => _isLoading;
  bool get isFavorite => _isFavorite;

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

  void loadFavoriteStatus(String id) async {
    List<FavoriteRecipe> favoriteRecipes =
        await DatabaseHelper().getAllFavoriteRecipes();
    FavoriteRecipe? recipe =
        favoriteRecipes.firstWhere((recipe) => recipe.id == id,
            orElse: () => FavoriteRecipe(
                  id: id,
                  title: '',
                  image: '',
                  aggregateLikes: '',
                  readyInMinutes: '',
                  servings: '',
                  isFavorite: false,
                ));
    _isFavorite = recipe.isFavorite;
    notifyListeners();
  }

  void toggleFavorite(String id, BuildContext context) async {
    _isFavorite =! _isFavorite;
    notifyListeners();
    FavoriteRecipe recipe = FavoriteRecipe(
      id: id,
      title: Provider.of<DetailScreenProvider>(context, listen: false)
              .detailRecipeModel!
              .title ??
          '',
      image: Provider.of<DetailScreenProvider>(context, listen: false)
              .detailRecipeModel!
              .image ??
          '',
      aggregateLikes: Provider.of<DetailScreenProvider>(context, listen: false)
          .detailRecipeModel!
          .aggregateLikes
          .toString(),
      readyInMinutes: Provider.of<DetailScreenProvider>(context, listen: false)
          .detailRecipeModel!
          .readyInMinutes
          .toString(),
      servings: Provider.of<DetailScreenProvider>(context, listen: false)
          .detailRecipeModel!
          .servings
          .toString(),
      isFavorite: _isFavorite,
    );

    if (_isFavorite) {
      await DatabaseHelper().addFavoriteRecipe(recipe);
    } else {
      await DatabaseHelper().removeFavoriteRecipe(recipe.id);
    }
  }
}
