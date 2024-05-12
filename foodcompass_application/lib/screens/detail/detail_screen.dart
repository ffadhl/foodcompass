import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/image_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/providers/detail_screen_provider.dart';
import 'package:foodcompass_application/screens/detail/widget/detail_list_dishtype_widget.dart';
import 'package:foodcompass_application/screens/detail/widget/detail_list_nutrition_widget.dart';
import 'package:foodcompass_application/screens/detail/content/ingredient_widget.dart';
import 'package:foodcompass_application/screens/detail/content/similar_widget.dart';
import 'package:foodcompass_application/screens/timer/timer_screen.dart';
import 'package:foodcompass_application/widgets/global_button_widget.dart';
import 'package:foodcompass_application/widgets/global_loading_widget.dart';
import 'package:foodcompass_application/widgets/global_no_data_widget.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final String id;
  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DetailScreenProvider>(context, listen: false)
          .getDetailRecipe(widget.id);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DetailScreenProvider>(context, listen: false)
          .loadFavoriteStatus(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailScreenProvider>(
        builder: (context, detailScreenProvider, _) {
          return detailScreenProvider.isLoading
              ? const Center(
                  child: MyLoading(),
                )
              : detailScreenProvider.detailRecipeModel == null
                  ? const GlobalNoDataWidget(
                      titleMessage: 'OOPS!',
                      message: 'Something went wrong.',
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width - 75.0,
                                child: CachedNetworkImage(
                                  imageUrl: detailScreenProvider
                                              .detailRecipeModel!.image !=
                                          null
                                      ? detailScreenProvider
                                          .detailRecipeModel!.image
                                          .toString()
                                      : 'No data available',
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    ImageConstant.dummyFood,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 40.0,
                                left: 10.0,
                                child: IconButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                      ColorConstant.colorWhite,
                                    ),
                                    shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    LineIcons.arrowLeft,
                                    color: ColorConstant.colorOrange,
                                    size: 20.0,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 40.0,
                                right: 10.0,
                                child: IconButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                      ColorConstant.colorWhite,
                                    ),
                                    shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    detailScreenProvider.toggleFavorite(
                                        widget.id, context);
                                  },
                                  icon: Icon(
                                    detailScreenProvider.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 20.0,
                                    color: detailScreenProvider.isFavorite
                                        ? Colors.red
                                        : ColorConstant.colorOrange,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 40,
                                left: 10,
                                child: Container(
                                  height: 30.0,
                                  width: 80.0,
                                  decoration: BoxDecoration(
                                    color: ColorConstant.colorWhite,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.favorite_rounded,
                                          size: 16.0,
                                          color: Colors.red,
                                        ),
                                        const SizedBox(width: 5.0),
                                        Text(
                                          detailScreenProvider
                                                      .detailRecipeModel!
                                                      .aggregateLikes !=
                                                  null
                                              ? detailScreenProvider
                                                  .detailRecipeModel!
                                                  .aggregateLikes
                                                  .toString()
                                              : 'No data available',
                                          style: TextStyleConstant
                                              .poppinsSemiBold
                                              .copyWith(
                                            color: ColorConstant.colorBlack,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0.0,
                                right: 0.0,
                                top: MediaQuery.of(context).size.width - 110.0,
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: const BoxDecoration(
                                    color: ColorConstant.colorWhite,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: 5.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                              color: ColorConstant.colorGrey20,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    detailScreenProvider
                                                .detailRecipeModel!.title !=
                                            null
                                        ? detailScreenProvider
                                            .detailRecipeModel!.title
                                            .toString()
                                        : 'No data available',
                                    style: TextStyleConstant.poppinsSemiBold
                                        .copyWith(
                                      fontSize: 25.0,
                                      color: ColorConstant.colorBlack,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Row(
                                  children: [
                                    const Icon(
                                      LineIcons.clock,
                                      color: ColorConstant.colorOrange,
                                      size: 30.0,
                                    ),
                                    const SizedBox(width: 5.0),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            detailScreenProvider
                                                        .detailRecipeModel!
                                                        .readyInMinutes !=
                                                    null
                                                ? detailScreenProvider
                                                    .detailRecipeModel!
                                                    .readyInMinutes
                                                    .toString()
                                                : 'No data available',
                                            style: TextStyleConstant
                                                .poppinsSemiBold
                                                .copyWith(
                                              fontSize: 20.0,
                                              color: ColorConstant.colorOrange,
                                            ),
                                          ),
                                          Text(
                                            'Minutes',
                                            style: TextStyleConstant
                                                .poppinsRegular
                                                .copyWith(
                                              fontSize: 14.0,
                                              color: ColorConstant.colorBlack,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    const Icon(
                                      LineIcons.utensils,
                                      color: ColorConstant.colorOrange,
                                      size: 30.0,
                                    ),
                                    const SizedBox(width: 5.0),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: ColorConstant.colorGrey20,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Serves ${detailScreenProvider.detailRecipeModel!.servings.toString()}',
                                          style: TextStyleConstant
                                              .poppinsRegular
                                              .copyWith(
                                            fontSize: 14.0,
                                            color: ColorConstant.colorGrey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    'Summary',
                                    style: TextStyleConstant.poppinsSemiBold
                                        .copyWith(
                                      fontSize: 18.0,
                                      color: ColorConstant.colorBlack,
                                    ),
                                  ),
                                ),
                                Html(
                                  data: detailScreenProvider
                                              .detailRecipeModel!.summary !=
                                          null
                                      ? detailScreenProvider
                                          .detailRecipeModel!.summary
                                          .toString()
                                      : 'No data available',
                                  style: {
                                    'body': Style(
                                      fontSize: FontSize(14.0),
                                      textAlign: TextAlign.justify,
                                      color: ColorConstant.colorBlack,
                                      fontFamily: TextStyleConstant
                                          .poppinsRegular.fontFamily,
                                    ),
                                  },
                                ),
                                ExpansionTileTheme(
                                  data: ExpansionTileThemeData(
                                    iconColor: ColorConstant.colorOrange,
                                    collapsedIconColor:
                                        ColorConstant.colorOrange,
                                    tilePadding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    collapsedShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: ExpansionTile(
                                    title: Text(
                                      'Nutrition',
                                      style: TextStyleConstant.poppinsMedium
                                          .copyWith(
                                        fontSize: 14.0,
                                        color: ColorConstant.colorBlack,
                                      ),
                                    ),
                                    children: [
                                      NutritionListWidget(
                                        calories: detailScreenProvider
                                                .detailNutritionModel?.calories
                                                .toString() ??
                                            '-',
                                        carbs: detailScreenProvider
                                                .detailNutritionModel?.carbs
                                                .toString() ??
                                            '-',
                                        fat: detailScreenProvider
                                                .detailNutritionModel?.fat
                                                .toString() ??
                                            '-',
                                        protein: detailScreenProvider
                                                .detailNutritionModel?.protein
                                                .toString() ??
                                            '-',
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                DishTypeListWidget(
                                  dishTypeList: detailScreenProvider
                                              .detailRecipeModel!.dishTypes !=
                                          null
                                      ? detailScreenProvider
                                          .detailRecipeModel!.dishTypes!
                                      : [],
                                ),
                                const SizedBox(height: 20.0),
                                IngredientWidget(
                                    detailScreenProvider: detailScreenProvider),
                                const SizedBox(height: 20.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        'Instructions',
                                        style: TextStyleConstant.poppinsSemiBold
                                            .copyWith(
                                          fontSize: 18.0,
                                          color: ColorConstant.colorBlack,
                                        ),
                                      ),
                                    ),
                                    Html(
                                      data: detailScreenProvider
                                                  .detailRecipeModel!
                                                  .instructions !=
                                              null
                                          ? detailScreenProvider
                                              .detailRecipeModel!.instructions
                                              .toString()
                                          : 'No data available',
                                      style: {
                                        'body': Style(
                                          fontSize: FontSize(14.0),
                                          textAlign: TextAlign.justify,
                                          color: ColorConstant.colorBlack,
                                          fontFamily: TextStyleConstant
                                              .poppinsRegular.fontFamily,
                                        ),
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0),
                                SimilarWidget(
                                    detailScreenProvider: detailScreenProvider),
                                Center(
                                  child: GlobalButtonWidget(
                                    height: 50,
                                    width: 250,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TimerScreen(
                                            minutes: detailScreenProvider
                                                    .detailRecipeModel!
                                                    .readyInMinutes ??
                                                0,
                                          ),
                                        ),
                                      );
                                    },
                                    title: 'Timer',
                                    textColor: ColorConstant.colorWhite,
                                    color: ColorConstant.colorOrange,
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
        },
      ),
    );
  }
}
