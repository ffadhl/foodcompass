import 'package:flutter/material.dart';
import 'package:foodcompass_application/screens/home/widget/item_horizontal_list_widget.dart';

class HorizontalListWidget extends StatelessWidget {
  const HorizontalListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ItemHorizontalListWidget(title: "Drinks"),
          ItemHorizontalListWidget(title: "Baking"),
          ItemHorizontalListWidget(title: "Desserts"),
          ItemHorizontalListWidget(title: "Vegetarian"),
          ItemHorizontalListWidget(title: "Sauces"),
          ItemHorizontalListWidget(title: "Stir Fry"),
          ItemHorizontalListWidget(title: "Seafood"),
          ItemHorizontalListWidget(title: "Meat"),
          ItemHorizontalListWidget(title: "Lamb"),
          ItemHorizontalListWidget(title: "Pork"),
          ItemHorizontalListWidget(title: "Poultry"),
          ItemHorizontalListWidget(title: "Duck"),
          ItemHorizontalListWidget(title: "Turkey"),
          ItemHorizontalListWidget(title: "Chicken"),
          ItemHorizontalListWidget(title: "Sausages"),
          ItemHorizontalListWidget(title: "Mince"),
          ItemHorizontalListWidget(title: "Burgers"),
          ItemHorizontalListWidget(title: "Pies"),
          ItemHorizontalListWidget(title: "Pasta"),
          ItemHorizontalListWidget(title: "Noodles"),
          ItemHorizontalListWidget(title: "Rice"),
          ItemHorizontalListWidget(title: "Pizza"),
          ItemHorizontalListWidget(title: "Sides"),
          ItemHorizontalListWidget(title: "Salads"),
          ItemHorizontalListWidget(title: "Soups"),
          ItemHorizontalListWidget(title: "Snacks"),
        ],
      ),
    );
  }
}
