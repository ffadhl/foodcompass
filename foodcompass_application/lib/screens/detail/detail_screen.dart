import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/models/detail_model.dart';
import 'package:foodcompass_application/models/failure_model.dart';
import 'package:foodcompass_application/screens/detail/widget/detail_list_dishtype_widget.dart';
import 'package:foodcompass_application/screens/detail/widget/detail_list_ingredient_widget.dart';
import 'package:foodcompass_application/services/api/get_detail_recipe.dart';
import 'package:foodcompass_application/widgets/loading_widget.dart';
import 'package:line_icons/line_icons.dart';

class DetailScreen extends StatefulWidget {
  final String id;
  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  DetailRecipeModel? _detailRecipeModel;

  Future<void> _getDetailRecipe() async {
    try {
      final getInformation = GetInformation();
      _detailRecipeModel = await getInformation.getDetailRecipe(widget.id);
      setState(() {});
    } on FailureMessage catch (e) {
      print(e.message);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    _getDetailRecipe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _detailRecipeModel == null
          ? const Center(
              child: MyLoading(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width - 75.0,
                        child: CachedNetworkImage(
                          imageUrl: _detailRecipeModel!.image ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 40.0,
                        left: 10.0,
                        child: IconButton(
                          style: ButtonStyle(
                            backgroundColor: const MaterialStatePropertyAll(
                              ColorConstant.colorWhite,
                            ),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            LineIcons.arrowLeft,
                            color: ColorConstant.colorOrange,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 40.0,
                        right: 10.0,
                        child: IconButton(
                          style: ButtonStyle(
                            backgroundColor: const MaterialStatePropertyAll(
                              ColorConstant.colorWhite,
                            ),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            print('Fav');
                          },
                          icon: const Icon(
                            Icons.favorite_border,
                            color: ColorConstant.colorOrange,
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.favorite_rounded,
                                  size: 16.0,
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 5.0),
                                Text(
                                  _detailRecipeModel!.aggregateLikes.toString(),
                                  style: TextStyleConstant.poppinsSemiBold
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
                      )),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            _detailRecipeModel!.title.toString(),
                            style: TextStyleConstant.poppinsSemiBold.copyWith(
                              fontSize: 25.0,
                              color: ColorConstant.colorBlack,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        //make serveinminutes
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
                                    _detailRecipeModel!.readyInMinutes.toString(),
                                    style: TextStyleConstant.poppinsSemiBold.copyWith(
                                      fontSize: 20.0,
                                      color: ColorConstant.colorOrange,
                                    ),
                                  ),
                                  Text(
                                    'Minutes',
                                    style: TextStyleConstant.poppinsRegular.copyWith(
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
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Serves ${_detailRecipeModel!.servings.toString()}',
                                  style: TextStyleConstant.poppinsRegular.copyWith(
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Summary',
                            style: TextStyleConstant.poppinsSemiBold.copyWith(
                              fontSize: 18.0,
                              color: ColorConstant.colorBlack,
                            ),
                          ),
                        ),
                        Html(
                          data: _detailRecipeModel!.summary ?? '',
                          style: {
                            'body': Style(
                              fontSize: FontSize(14.0),
                              textAlign: TextAlign.justify,
                              color: ColorConstant.colorBlack,
                              fontFamily:
                                  TextStyleConstant.poppinsRegular.fontFamily,
                            ),
                          },
                        ),
                        const SizedBox(height: 5.0),
                        DishTypeListWidget(
                          dishTypeList: _detailRecipeModel!.dishTypes!,
                        ),
                        const SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Ingredients',
                            style: TextStyleConstant.poppinsSemiBold.copyWith(
                              fontSize: 18.0,
                              color: ColorConstant.colorBlack,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        IngredientListWidget(
                          ingredientList:
                              _detailRecipeModel!.extendedIngredients!,
                        ),
                        const SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Instructions',
                            style: TextStyleConstant.poppinsSemiBold.copyWith(
                              fontSize: 18.0,
                              color: ColorConstant.colorBlack,
                            ),
                          ),
                        ),
                        Html(
                          data: _detailRecipeModel!.instructions,
                          style: {
                            'body': Style(
                              fontSize: FontSize(14.0),
                              textAlign: TextAlign.justify,
                              color: ColorConstant.colorBlack,
                              fontFamily:
                                  TextStyleConstant.poppinsRegular.fontFamily,
                            ),
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
