import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';

class BannerDotWidget extends StatelessWidget {
  final bool isActive;

  const BannerDotWidget({
    super.key,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 4,
        width: isActive ? 25 : 4,
        decoration: BoxDecoration(
          color:
              isActive ? ColorConstant.colorOrange : ColorConstant.colorOrange20,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      ),
    );
  }
}