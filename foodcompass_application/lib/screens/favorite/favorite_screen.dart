import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/lottie_animation_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/models/favorite_model.dart';
import 'package:foodcompass_application/providers/favorite_screen_provider.dart';
import 'package:foodcompass_application/screens/favorite/widget/item_favorite_screen_widget.dart';
import 'package:foodcompass_application/widgets/loading_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FavoriteScreenProvider>(context, listen: false)
          .fetchFavoriteRecipes();
    });
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
      body: Consumer<FavoriteScreenProvider>(
          builder: (context, favoriteScreenProvider, _) {
        return favoriteScreenProvider.isLoading
            ? const Center(
                child: MyLoading(),
              )
            : favoriteScreenProvider.favoriteRecipes.isEmpty
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
                    itemCount: favoriteScreenProvider.favoriteRecipes.length,
                    itemBuilder: (context, index) {
                      FavoriteRecipe recipe =
                          favoriteScreenProvider.favoriteRecipes[index];
                      return ItemFavoriteScreenWidget(recipe: recipe);
                    },
                  );
      }),
    );
  }
}
