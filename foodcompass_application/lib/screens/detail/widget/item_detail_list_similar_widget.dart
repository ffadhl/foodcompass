import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/image_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/models/detail_similar_food_model.dart';
import 'package:foodcompass_application/screens/detail/detail_screen.dart';
import 'package:line_icons/line_icons.dart';

class ItemListSimilarWidget extends StatefulWidget {
  final DetailSimilarModel similarFood;

  const ItemListSimilarWidget({
    super.key,
    required this.similarFood,
  });

  @override
  State<ItemListSimilarWidget> createState() => _ItemListSimilarWidgetState();
}

class _ItemListSimilarWidgetState extends State<ItemListSimilarWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              id: widget.similarFood.id.toString(),
            ),
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
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://img.spoonacular.com/recipes/${widget.similarFood.id}-312x231.${widget.similarFood.imageType}",
                  height: 150.0,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Image.asset(
                    ImageConstant.dummyFood,
                    height: 150.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.similarFood.title,
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
                                      "${widget.similarFood.readyInMinutes} menit",
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
                                  "${widget.similarFood.servings} porsi",
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
