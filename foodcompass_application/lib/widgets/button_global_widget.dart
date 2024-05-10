import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';

class ButtonGlobalWidget extends StatelessWidget {
  final String title;
  final int height;
  final int width;
  final Color? color;
  final Color? textColor;
  final bool isWithBorder;
  final Color? borderColor;
  final Function()? onTap;

  const ButtonGlobalWidget({
    super.key,
    required this.title,
    required this.textColor,
    this.isWithBorder = false,
    this.borderColor,
    required this.onTap,
    required this.color,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height.toDouble(),
        width: width.toDouble(),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            32,
          ),
          border: isWithBorder
              ? Border.all(
                  color: borderColor ?? ColorConstant.colorOrange,
                )
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyleConstant.poppinsMedium.copyWith(
            color: textColor,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
