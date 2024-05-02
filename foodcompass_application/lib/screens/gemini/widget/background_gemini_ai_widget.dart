import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/image_constant.dart';

class BackgorundGeminiAi extends StatelessWidget {
  const BackgorundGeminiAi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorConstant.colorWhite.withOpacity(0.5),
            ColorConstant.colorWhite.withOpacity(0.5),
          ],
        ),
        image: DecorationImage(
          image: AssetImage(ImageConstant.chatBotBackground),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
