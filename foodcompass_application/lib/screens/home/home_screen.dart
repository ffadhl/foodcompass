// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/models/failure_model.dart';
import 'package:foodcompass_application/models/food_list_homescreen.dart';
import 'package:foodcompass_application/screens/home/widget/food_list_home_screen_widget.dart';
import 'package:foodcompass_application/services/api/spoonacular_api.dart';
import 'package:foodcompass_application/widgets/search_bar_global_widget.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FoodList? breakfastRecipes;
  late FoodList? lunchRecipes;
  late FoodList? drinkRecipes;

  @override
  void initState() {
    super.initState();
    _fetchRecipes();
  }

  Future<void> _fetchRecipes() async {
    try {
      final spoonacularApi = SpoonacularApi();
      breakfastRecipes = await spoonacularApi.getRecipe("breakfast", 5);
      lunchRecipes = await spoonacularApi.getRecipe("lunch", 10);
      drinkRecipes = await spoonacularApi.getRecipe("drink", 5);
      setState(() {
        breakfastRecipes = breakfastRecipes;
        lunchRecipes = lunchRecipes;
        drinkRecipes = drinkRecipes;
      });
    } on FailureMessage catch (e) {
      print(e.message);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Food',
                style: TextStyleConstant.poppinsMedium.copyWith(
                  color: ColorConstant.colorBlack,
                  fontSize: 20.0,
                ),
              ),
              TextSpan(
                text: 'Compass',
                style: TextStyleConstant.poppinsMedium.copyWith(
                  color: ColorConstant.colorOrange,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: breakfastRecipes == null || lunchRecipes == null || drinkRecipes == null
        ? const Center(
            child: CircularProgressIndicator(), // Or any other loading indicator
          )
        : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              Text(
                'Temukan Resep \nMakanan Favoritmu',
                style: TextStyleConstant.poppinsSemiBold.copyWith(
                  color: ColorConstant.colorBlack,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 20.0),
              const SearchBarWidget(
                hintText: 'Cari resep makanan',
              ),
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Sarapan Populer",
                        style: TextStyleConstant.poppinsSemiBold.copyWith(
                          color: ColorConstant.colorBlack,
                          fontSize: 16.0,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        LineIcons.arrowRight,
                        color: ColorConstant.colorOrange,
                        size: 22.0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  FoodListWidget(foodList: breakfastRecipes!),
                ],
              ),
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Makan Siang Populer",
                        style: TextStyleConstant.poppinsSemiBold.copyWith(
                          color: ColorConstant.colorBlack,
                          fontSize: 16.0,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        LineIcons.arrowRight,
                        color: ColorConstant.colorOrange,
                        size: 22.0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  FoodListWidget(foodList: lunchRecipes!),
                ],
              ),
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Minuman Populer",
                        style: TextStyleConstant.poppinsSemiBold.copyWith(
                          color: ColorConstant.colorBlack,
                          fontSize: 16.0,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        LineIcons.arrowRight,
                        color: ColorConstant.colorOrange,
                        size: 22.0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  FoodListWidget(foodList: drinkRecipes!),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
