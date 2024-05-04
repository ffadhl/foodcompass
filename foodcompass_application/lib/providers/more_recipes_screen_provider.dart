
import 'package:flutter/material.dart';

class MoreAllRecipesProvider extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  void loadData() {
    Future.delayed(const Duration(seconds: 2), () {
      _isLoading = false;
      notifyListeners();
    });
  }
  
}