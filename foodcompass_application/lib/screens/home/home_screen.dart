// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/providers/home_screen_provider.dart';
import 'package:foodcompass_application/screens/home/widget/breakfast_recipe_widget.dart';
import 'package:foodcompass_application/screens/home/widget/drink_recipe_widget.dart';
import 'package:foodcompass_application/screens/home/widget/lunch_recipe_widget.dart';
import 'package:foodcompass_application/screens/search/search_home_screen/search_home_screen.dart';
import 'package:foodcompass_application/widgets/loading_widget.dart';
import 'package:foodcompass_application/widgets/no_data_global_widget.dart';
import 'package:foodcompass_application/widgets/search_bar_global_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _searchBar = TextEditingController();

  @override
  void dispose() {
    _searchBar.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeScreenProvider>(context, listen: false).fetchRecipes();
    });
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
          return homeScreenProvider.isLoading
              ? const Center(child: MyLoading())
              : homeScreenProvider.breakfastRecipes == null ||
                      homeScreenProvider.lunchRecipes == null ||
                      homeScreenProvider.drinkRecipes == null
                  ? const NoDataWidget(
                      titleMessage: 'OOPS!',
                      message: 'Something went wrong',
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10.0),
                            Text(
                              'Find your \nFavorite food recipes.',
                              style: TextStyleConstant.poppinsSemiBold.copyWith(
                                color: ColorConstant.colorBlack,
                                fontSize: 20.0,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            SearchBarWidget(
                              key: _formKey,
                              controller: _searchBar,
                              hintText: 'Search for food recipes.',
                              onSubmitted: (query) {
                                if (query.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor:
                                          ColorConstant.colorOrange20,
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'OOPS! error: ',
                                            style: TextStyleConstant
                                                .poppinsSemiBold
                                                .copyWith(
                                              color: ColorConstant.colorOrange,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          Text(
                                            'Please fill in the search form first.',
                                            style: TextStyleConstant
                                                .poppinsRegular
                                                .copyWith(
                                              color: ColorConstant.colorOrange,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SearchHomeScreen(searchQuery: query),
                                    ),
                                  );
                                }
                                _searchBar.clear();
                              },
                            ),
                            const SizedBox(height: 20.0),
                            BreakfastRecipesWidget(
                                homeScreenProvider: homeScreenProvider),
                            const SizedBox(height: 20.0),
                            LunchRecipeWidget(
                                homeScreenProvider: homeScreenProvider),
                            const SizedBox(height: 20.0),
                            DrinkRecipeWidget(
                                homeScreenProvider: homeScreenProvider),
                          ],
                        ),
                      ),
                    );
        },
      ),
    );
  }
}
