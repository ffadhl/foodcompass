import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/lottie_animation_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:lottie/lottie.dart';

class NoDataDetailScreen extends StatelessWidget {
  const NoDataDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            LottieConstant.searchNoResult,
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 10.0),
          Text(
            'OOPS, Something went wrong!',
            style: TextStyleConstant.poppinsSemiBold.copyWith(
              color: ColorConstant.colorBlack,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            'No data found!',
            style: TextStyleConstant.poppinsRegular.copyWith(
              color: ColorConstant.colorBlack,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
