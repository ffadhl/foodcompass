import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:line_icons/line_icons.dart';

class SearchBarWidget extends StatelessWidget {
  final String hintText;
  final Color? fillColor;
  final TextEditingController? controller;
  final Function(String)? onSubmitted;

  const SearchBarWidget({
    super.key,
    required this.hintText,
    this.fillColor,
    this.onSubmitted,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted, 
      style: TextStyleConstant.poppinsRegular.copyWith(
        color: ColorConstant.colorBlack,
        fontSize: 12.0,
      ),
      cursorColor: ColorConstant.colorOrange,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyleConstant.poppinsRegular.copyWith(
          color: ColorConstant.colorGrey50,
          fontSize: 14.0,
        ),
        prefixIcon: const Icon(
          LineIcons.search,
          color: ColorConstant.colorGrey50,
          size: 18.0,
        ),
        filled: true,
        fillColor: fillColor ?? ColorConstant.colorGrey20,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
    );
  }
}
