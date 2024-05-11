import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';

class BannerHomeScreenWidget extends StatelessWidget {
  final String imagePath;
  const BannerHomeScreenWidget({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: ColorConstant.colorGrey50,
              blurRadius: 5.0,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset(
            imagePath,
          ),
        ),
      ),
    );
  }
}
