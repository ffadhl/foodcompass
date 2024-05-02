import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/image_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';

class ItemHorizontalListWidget extends StatelessWidget {
  final String title;
  const ItemHorizontalListWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 110.0,
          width: 65.0,
          margin: const EdgeInsets.only(bottom: 10.0),
          decoration: BoxDecoration(
            color: ColorConstant.colorOrange,
            boxShadow: [
              BoxShadow(
                color: ColorConstant.colorOrange.withOpacity(0.5),
                blurRadius: 10.0,
                offset: const Offset(0, 5),
              ),
            ],
            borderRadius: BorderRadius.circular(100),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  color: ColorConstant.colorWhite,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Image.asset(
                    ImageConstant.orangeLogo,
                    height: 25,
                    width: 25,
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                title,
                style: TextStyleConstant.poppinsMedium.copyWith(
                  color: ColorConstant.colorWhite,
                  fontSize: 10.0,
                ),
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}
