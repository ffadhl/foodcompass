import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/models/detail_model.dart';

class ItemIngredientListWidget extends StatefulWidget {
  final ExtendedIngredient ingredient;
  const ItemIngredientListWidget({super.key, required this.ingredient});

  @override
  State<ItemIngredientListWidget> createState() =>
      _ItemIngredientListWidgetState();
}

class _ItemIngredientListWidgetState extends State<ItemIngredientListWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100.0,
        width: 150.0,
        decoration: BoxDecoration(
          color: ColorConstant.colorWhite,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: ColorConstant.colorGrey20,
              blurRadius: 10.0,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl:
                  "https://spoonacular.com/cdn/ingredients_500x500/${widget.ingredient.image}",
              fit: BoxFit.cover,
              height: 100.0,
              width: 100.0,
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.ingredient.original.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyleConstant.poppinsRegular.copyWith(
                  fontSize: 12.0,
                  color: ColorConstant.colorBlack,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
