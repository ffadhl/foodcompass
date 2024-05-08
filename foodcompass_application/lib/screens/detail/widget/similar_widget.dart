import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/models/detail_similar_food_model.dart';
import 'package:foodcompass_application/providers/detail_screen_provider.dart';
import 'package:foodcompass_application/screens/detail/widget/detail_list_similar_widget.dart';

class SimilarWidget extends StatefulWidget {
  const SimilarWidget({
    super.key,
    required this.detailScreenProvider,
  });

  final DetailScreenProvider detailScreenProvider;

  @override
  State<SimilarWidget> createState() => _SimilarWidgetState();
}

class _SimilarWidgetState extends State<SimilarWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Similar Recipes',
            style: TextStyleConstant.poppinsSemiBold.copyWith(
              fontSize: 18.0,
              color: ColorConstant.colorBlack,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        SimilarListWidget(
          similarFoodList: widget.detailScreenProvider.similarFoodList ??
              SimilarFoodList(list: []),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
