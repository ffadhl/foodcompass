import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/providers/home_screen_provider.dart';
import 'package:foodcompass_application/screens/home/content/more_all_recipe_screen.dart';
import 'package:foodcompass_application/screens/home/widget/food_list_home_screen_widget.dart';
import 'package:line_icons/line_icons.dart';

class LunchRecipeWidget extends StatefulWidget {
  final HomeScreenProvider homeScreenProvider;
  const LunchRecipeWidget({
    super.key,
    required this.homeScreenProvider,
  });

  @override
  State<LunchRecipeWidget> createState() => _LunchRecipeWidgetState();
}

class _LunchRecipeWidgetState extends State<LunchRecipeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Popular Lunch",
              style: TextStyleConstant.poppinsSemiBold.copyWith(
                color: ColorConstant.colorBlack,
                fontSize: 16.0,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MoreAllRecipesScreen(
                        foodList: widget.homeScreenProvider.lunchRecipes!),
                  ),
                );
              },
              icon: const Icon(
                LineIcons.arrowRight,
                color: ColorConstant.colorOrange,
                size: 22.0,
              ),
            )
          ],
        ),
        const SizedBox(height: 20.0),
        FoodListWidget(foodList: widget.homeScreenProvider.lunchRecipes!),
      ],
    );
  }
}