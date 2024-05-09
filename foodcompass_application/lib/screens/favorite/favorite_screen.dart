import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/lottie_animation_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/helpers/database_helper.dart';
import 'package:foodcompass_application/models/favorite_model.dart';
import 'package:foodcompass_application/screens/detail/detail_screen.dart';
import 'package:lottie/lottie.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late List<FavoriteRecipe> _favoriteRecipes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFavoriteRecipes();
  }

  Future<void> _fetchFavoriteRecipes() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<FavoriteRecipe> recipes =
          await DatabaseHelper().getAllFavoriteRecipes();
      setState(() {
        _favoriteRecipes = recipes;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching favorite recipes: $e');
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _favoriteRecipes.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        LottieConstant.favoriteScreen,
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(height: 10.0),
                      Column(
                        children: [
                          Text(
                            'OOPS!',
                            style: TextStyleConstant.poppinsSemiBold.copyWith(
                              color: ColorConstant.colorBlack,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            'No Favorite Recipes Found!',
                            style: TextStyleConstant.poppinsRegular.copyWith(
                              color: ColorConstant.colorBlack,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _favoriteRecipes.length,
                  itemBuilder: (context, index) {
                    FavoriteRecipe recipe = _favoriteRecipes[index];
                    return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                id: recipe.id,
                              ),
                            ),
                          );
                        },
                        leading: CachedNetworkImage(
                          imageUrl: recipe.image,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          recipe.title,
                          style: TextStyleConstant.poppinsMedium.copyWith(
                            color: ColorConstant.colorBlack,
                            fontSize: 14.0,
                          ),
                        ),
                        //make time and servings dynamic
                        subtitle: Text(
                          '${recipe.readyInMinutes} minutes | ${recipe.servings} servings',
                          style: TextStyleConstant.poppinsRegular.copyWith(
                            color: ColorConstant.colorBlack,
                            fontSize: 12.0,
                          ),
                        ));
                  },
                ),
    );
  }
}
