import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodcompass_application/models/food_model.dart';
import 'package:foodcompass_application/screens/home/widget/item_food_list_home_screen_widget.dart';

class FoodListWidget extends StatefulWidget {
  final FoodList foodList;
  const FoodListWidget({
    super.key,
    required this.foodList,
  });

  @override
  State<FoodListWidget> createState() => _FoodListWidgetState();
}

class _FoodListWidgetState extends State<FoodListWidget> {
  int maxItemCount = 5;
  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      height: 280.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: min(
          widget.foodList.list.length,
          maxItemCount,
        ),
        itemBuilder: (context, index) {
          final foodList = widget.foodList.list[index];
          return ItemListFoodWidget(food: foodList);
        },
      ),
    );
  }
}
