import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/models/detail_similar_food_model.dart';
import 'package:foodcompass_application/screens/detail/widget/item_detail_list_similar_widget.dart';

class SimilarListWidget extends StatelessWidget {
  final SimilarFoodList similarFoodList;

  const SimilarListWidget({
    super.key,
    required this.similarFoodList,
  });

  @override
  Widget build(BuildContext context) {
    if (similarFoodList.list.isEmpty) {
      return Center(
        child: Text(
          'Tidak ada resep yang serupa',
          style: TextStyleConstant.poppinsRegular.copyWith(
            fontSize: 14.0,
            color: ColorConstant.colorBlack,
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 280.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: similarFoodList.list.length,
          itemBuilder: (context, index) {
            final similarList = similarFoodList.list[index];
            return ItemListSimilarWidget(similarFood: similarList);
          },
        ),
      );
    }
  }
}
