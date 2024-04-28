import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';

class WelcomeScreenContent extends StatelessWidget {
  const WelcomeScreenContent({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  final String title;
  final String description;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Image.asset(
          imagePath,
          width: 100,
          height: 100,
        ),
        const Spacer(),
        Text(
          title,
          style: TextStyleConstant.poppinsSemiBold.copyWith(
            fontSize: 18,
            color: ColorConstant.colorBlack,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: TextStyleConstant.poppinsRegular.copyWith(
            fontSize: 12,
            color: ColorConstant.colorBlack20,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 75),
      ],
    );
  }
}
