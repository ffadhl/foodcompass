// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/providers/home_screen_provider.dart';
import 'package:foodcompass_application/screens/home/widget/food_list_home_screen_widget.dart';
import 'package:foodcompass_application/widgets/search_bar_global_widget.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<HomeScreenProvider>(context, listen: false).fetchRecipes();
    super.initState();
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
      body: Consumer<HomeScreenProvider>(
          builder: (context, homeScreenProvider, _) {
        final homeScreenProvider = Provider.of<HomeScreenProvider>(context);
        return SingleChildScrollView(
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
                    FoodListWidget(
                        foodList: homeScreenProvider.breakfastRecipes!),
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
                    FoodListWidget(foodList: homeScreenProvider.lunchRecipes!),
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
                    FoodListWidget(foodList: homeScreenProvider.drinkRecipes!),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
