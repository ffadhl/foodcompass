import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/image_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/models/favorite_model.dart';
import 'package:foodcompass_application/providers/favorite_screen_provider.dart';
import 'package:foodcompass_application/screens/detail/detail_screen.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class ItemFavoriteScreenWidget extends StatefulWidget {
  final FavoriteRecipe recipe;

  const ItemFavoriteScreenWidget({
    super.key,
    required this.recipe,
  });

  @override
  State<ItemFavoriteScreenWidget> createState() =>
      _ItemFavoriteScreenWidgetState();
}

class _ItemFavoriteScreenWidgetState extends State<ItemFavoriteScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              id: widget.recipe.id,
            ),
          ),
        ).then((value) =>
            Provider.of<FavoriteScreenProvider>(context, listen: false)
                .fetchFavoriteRecipes());
      },
      child: Container(
        height: 100.0,
        margin: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          color: ColorConstant.colorWhite,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: ColorConstant.colorGrey.withOpacity(0.2),
              blurRadius: 5.0,
              spreadRadius: 2.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.recipe.image,
                height: 100.0,
                width: 100.0,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Image.asset(
                  ImageConstant.dummyFood,
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recipe.title,
                      style: TextStyleConstant.poppinsMedium.copyWith(
                        color: ColorConstant.colorBlack,
                        fontSize: 14.0,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const Icon(LineIcons.clock,
                            size: 16.0, color: ColorConstant.colorOrange),
                        const SizedBox(width: 5.0),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: ColorConstant.colorGrey20,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "${widget.recipe.readyInMinutes} minutes",
                                  style: TextStyleConstant.poppinsMedium
                                      .copyWith(
                                          color: ColorConstant.colorGrey,
                                          fontSize: 10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(LineIcons.utensils,
                                size: 16.0, color: ColorConstant.colorOrange),
                            const SizedBox(width: 5.0),
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: ColorConstant.colorGrey20,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      "${widget.recipe.servings} serves",
                                      style: TextStyleConstant.poppinsMedium
                                          .copyWith(
                                              color: ColorConstant.colorGrey,
                                              fontSize: 10.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.favorite_rounded,
                                size: 16.0,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 5.0),
                              Text(
                                widget.recipe.aggregateLikes,
                                style:
                                    TextStyleConstant.poppinsSemiBold.copyWith(
                                  color: ColorConstant.colorBlack,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
