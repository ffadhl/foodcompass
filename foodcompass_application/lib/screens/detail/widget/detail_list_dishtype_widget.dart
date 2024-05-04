import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';

class DishTypeListWidget extends StatelessWidget {
  final List<dynamic> dishTypeList;
  const DishTypeListWidget({
    super.key,
    required this.dishTypeList,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dishTypeList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              decoration: BoxDecoration(
                color: ColorConstant.colorGrey20,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  "#${dishTypeList[index]}",
                  style: TextStyleConstant.poppinsRegular.copyWith(
                    fontSize: 12.0,
                    color: ColorConstant.colorGrey80,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
