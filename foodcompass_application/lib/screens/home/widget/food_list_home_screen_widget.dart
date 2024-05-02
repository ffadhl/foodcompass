import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/models/food_list_homescreen.dart';
import 'package:line_icons/line_icons.dart';

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
  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      height: 250.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.foodList.list.length,
        itemBuilder: (context, index) {
          final foodList = widget.foodList.list[index];
          return ItemListFoodWidget(food: foodList);
        },
      ),
    );
  }
}

class ItemListFoodWidget extends StatefulWidget {
  final FoodModel food;

  const ItemListFoodWidget({
    super.key,
    required this.food,
  });

  @override
  State<ItemListFoodWidget> createState() => _ItemListFoodWidgetState();
}

class _ItemListFoodWidgetState extends State<ItemListFoodWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: 200.0,
      margin: const EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: CachedNetworkImage(
              imageUrl: widget.food.image,
              height: 140.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.food.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyleConstant.poppinsMedium.copyWith(fontSize: 14.0),
                ),
                const SizedBox(height: 5.0),
                Row(
                  children: [
                    const Icon(LineIcons.clock,
                        size: 16.0, color: ColorConstant.colorOrange),
                    const SizedBox(width: 5.0),
                    Text(
                      "${widget.food.readyInMinutes} menit",
                      style: TextStyleConstant.poppinsMedium.copyWith(
                          color: ColorConstant.colorGrey, fontSize: 10.0),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(LineIcons.utensils,
                        size: 16.0, color: ColorConstant.colorOrange),
                    const SizedBox(width: 5.0),
                    Text(
                      "${widget.food.servings} porsi",
                      style: TextStyleConstant.poppinsMedium.copyWith(
                          color: ColorConstant.colorGrey, fontSize: 10.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
