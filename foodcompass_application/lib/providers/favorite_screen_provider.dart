// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:foodcompass_application/helpers/database_helper.dart';
import 'package:foodcompass_application/models/favorite_model.dart';

class FavoriteScreenProvider extends ChangeNotifier {
  late List<FavoriteRecipe> _favoriteRecipes = [];
  bool _isLoading = true;

  List<FavoriteRecipe> get favoriteRecipes => _favoriteRecipes;
  bool get isLoading => _isLoading;

  Future<void> fetchFavoriteRecipes() async {
    _isLoading = true;
    notifyListeners();
    try {
      List<FavoriteRecipe> recipes =
          await DatabaseHelper().getAllFavoriteRecipes();
      _favoriteRecipes = recipes;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Error fetching favorite recipes: $e');
    }
  }
}
