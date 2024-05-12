import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/providers/detail_screen_provider.dart';
import 'package:foodcompass_application/screens/detail/widget/detail_list_ingredient_widget.dart';

class IngredientWidget extends StatefulWidget {
  const IngredientWidget({
    super.key,
    required this.detailScreenProvider,
  });

  final DetailScreenProvider detailScreenProvider;

  @override
  State<IngredientWidget> createState() => _IngredientWidgetState();
}

class _IngredientWidgetState extends State<IngredientWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Ingredients',
            style: TextStyleConstant.poppinsSemiBold.copyWith(
              fontSize: 18.0,
              color: ColorConstant.colorBlack,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        IngredientListWidget(
          ingredientList: widget
              .detailScreenProvider.detailRecipeModel!.extendedIngredients!,
        ),
      ],
    );
  }
}
