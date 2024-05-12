import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/image_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/models/food_model.dart';
import 'package:foodcompass_application/screens/detail/detail_screen.dart';
import 'package:line_icons/line_icons.dart';

class ItemListFoodMoreGridWidget extends StatefulWidget {
  final FoodModel food;

  const ItemListFoodMoreGridWidget({
    super.key,
    required this.food,
  });

  @override
  State<ItemListFoodMoreGridWidget> createState() => _ItemListFoodWidgetState();
}

class _ItemListFoodWidgetState extends State<ItemListFoodMoreGridWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(id: widget.food.id),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 200.0,
          width: 200.0,
          decoration: BoxDecoration(
            color: ColorConstant.colorWhite,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: ColorConstant.colorGrey50,
                offset: Offset(0, 0),
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.food.image,
                      height: 140.0,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Image.asset(
                        ImageConstant.dummyFood,
                        height: 140.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 10,
                    child: Container(
                      height: 30.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        color: ColorConstant.colorWhite,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.favorite_rounded,
                              size: 16.0,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              widget.food.aggregateLikes,
                              style: TextStyleConstant.poppinsSemiBold.copyWith(
                                color: ColorConstant.colorBlack,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.food.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleConstant.poppinsMedium
                          .copyWith(fontSize: 14.0),
                    ),
                    const SizedBox(height: 5.0),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Icon(LineIcons.clock,
                                size: 16.0, color: ColorConstant.colorOrange),
                            const SizedBox(width: 5.0),
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: ColorConstant.colorGrey20,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      "${widget.food.readyInMinutes} menit",
                                      style: TextStyleConstant.poppinsMedium
                                          .copyWith(
                                              color: ColorConstant.colorGrey,
                                              fontSize: 10.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Row(
                          children: [
                            const Icon(LineIcons.utensils,
                                size: 16.0, color: ColorConstant.colorOrange),
                            const SizedBox(width: 5.0),
                            Container(
                              decoration: BoxDecoration(
                                color: ColorConstant.colorGrey20,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "${widget.food.servings} porsi",
                                  style: TextStyleConstant.poppinsMedium
                                      .copyWith(
                                          color: ColorConstant.colorGrey,
                                          fontSize: 10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
