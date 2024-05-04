import 'package:flutter/material.dart';
import 'package:foodcompass_application/models/detail_model.dart';
import 'package:foodcompass_application/screens/detail/widget/item_detail_list_ingredient_widget.dart';

class IngredientListWidget extends StatelessWidget {
  final List<ExtendedIngredient> ingredientList;
  const IngredientListWidget({
    super.key,
    required this.ingredientList,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: ingredientList.length,
        itemBuilder: (context, index) {
          final ingredient = ingredientList[index];
          return ItemIngredientListWidget(ingredient: ingredient);
        },
      ),
    );
  }
}
