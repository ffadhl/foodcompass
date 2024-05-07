import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/providers/home_screen_provider.dart';
import 'package:foodcompass_application/screens/home/more/more_screen.dart';
import 'package:foodcompass_application/screens/home/widget/food_list_home_screen_widget.dart';
import 'package:line_icons/line_icons.dart';

class DrinkRecipeWidget extends StatefulWidget {
  const DrinkRecipeWidget({
    super.key,
    required this.homeScreenProvider,
  });

  final HomeScreenProvider homeScreenProvider;

  @override
  State<DrinkRecipeWidget> createState() => _DrinkRecipeWidgetState();
}

class _DrinkRecipeWidgetState extends State<DrinkRecipeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MoreAllRecipesScreen(
                        foodList: widget.homeScreenProvider.drinkRecipes!),
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
        FoodListWidget(foodList: widget.homeScreenProvider.drinkRecipes!),
      ],
    );
  }
}
