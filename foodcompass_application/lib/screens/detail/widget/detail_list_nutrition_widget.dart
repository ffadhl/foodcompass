import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:line_icons/line_icons.dart';

class NutritionListWidget extends StatefulWidget {
  final String? calories;
  final String? carbs;
  final String? fat;
  final String? protein;
  const NutritionListWidget({
    super.key,
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.protein,
  });

  @override
  State<NutritionListWidget> createState() => _NutritionListWidgetState();
}

class _NutritionListWidgetState extends State<NutritionListWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: ColorConstant.colorGrey20,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LineIcons.fire,
                size: 24,
                color: ColorConstant.colorOrange,
              ),
            ),
            title: Text(
              'Calories',
              style: TextStyleConstant.poppinsRegular.copyWith(
                fontSize: 14,
                color: ColorConstant.colorBlack,
              ),
            ),
            trailing: Text(
              widget.calories ?? '-',
              style: TextStyleConstant.poppinsMedium.copyWith(
                fontSize: 14,
                color: ColorConstant.colorOrange,
              ),
            ),
          ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: ColorConstant.colorGrey20,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LineIcons.breadSlice,
                size: 24,
                color: ColorConstant.colorOrange,
              ),
            ),
            title: Text(
              'Carbs',
              style: TextStyleConstant.poppinsRegular.copyWith(
                fontSize: 14,
                color: ColorConstant.colorBlack,
              ),
            ),
            trailing: Text(
              widget.carbs ?? '-',
              style: TextStyleConstant.poppinsMedium.copyWith(
                fontSize: 14,
                color: ColorConstant.colorOrange,
              ),
            ),
          ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: ColorConstant.colorGrey20,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LineIcons.weight,
                size: 24,
                color: ColorConstant.colorOrange,
              ),
            ),
            title: Text(
              'Fat',
              style: TextStyleConstant.poppinsRegular.copyWith(
                fontSize: 14,
                color: ColorConstant.colorBlack,
              ),
            ),
            trailing: Text(
              widget.fat ?? '-',
              style: TextStyleConstant.poppinsMedium.copyWith(
                fontSize: 14,
                color: ColorConstant.colorOrange,
              ),
            ),
          ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: ColorConstant.colorGrey20,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LineIcons.lightningBolt,
                size: 24,
                color: ColorConstant.colorOrange,
              ),
            ),
            title: Text(
              'Protein',
              style: TextStyleConstant.poppinsRegular.copyWith(
                fontSize: 14,
                color: ColorConstant.colorBlack,
              ),
            ),
            trailing: Text(
              widget.protein ?? '-',
              style: TextStyleConstant.poppinsMedium.copyWith(
                fontSize: 14,
                color: ColorConstant.colorOrange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
