import 'package:flutter/material.dart';
import 'package:foodcompass_application/models/failure_model.dart';
import 'package:foodcompass_application/models/search_model.dart';
import 'package:foodcompass_application/services/api/spoonacular_api.dart';

class SearchScreenProvider extends ChangeNotifier {
  List<Result> _searchResults = [];
  bool _isLoading = false;
  bool _isSearched = false;

  bool get isLoading => _isLoading;
  bool get isSearched => _isSearched;
  List<Result> get searchResults => _searchResults;

  Future<void> performSearch(String query) async {
    _isLoading = true;
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
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetState() {
    _isLoading = false;
    _isSearched = false;
    _searchResults = [];
    notifyListeners();
  }
}
