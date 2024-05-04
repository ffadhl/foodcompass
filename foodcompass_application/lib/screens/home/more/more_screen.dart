import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/models/food_model_home_screen_model.dart';
import 'package:foodcompass_application/providers/more_recipes_screen_provider.dart';
import 'package:foodcompass_application/screens/home/more/widget/item_food_list_more_grid.dart';
import 'package:foodcompass_application/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class MoreAllRecipesScreen extends StatefulWidget {
  final FoodList foodList;
  const MoreAllRecipesScreen({super.key, required this.foodList});

  @override
  State<MoreAllRecipesScreen> createState() => _MoreAllRecipesScreenState();
}

class _MoreAllRecipesScreenState extends State<MoreAllRecipesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MoreAllRecipesProvider>(context, listen: false).loadData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: ColorConstant.colorOrange),
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
      body: Consumer<MoreAllRecipesProvider>(
          builder: (context, moreAllRecipesProvider, _) {
        return moreAllRecipesProvider.isLoading
            ? const Center(
                child: MyLoading(),
              )
            : GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemCount: widget.foodList.list.length,
                itemBuilder: (context, index) {
                  final food = widget.foodList.list[index];
                  return ItemListFoodMoreGridWidget(
                    food: food,
                  );
                },
              );
      }),
    );
  }
}
