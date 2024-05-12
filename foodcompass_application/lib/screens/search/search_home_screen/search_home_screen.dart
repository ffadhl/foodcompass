import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/lottie_animation_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/providers/home_screen_provider.dart';
import 'package:foodcompass_application/screens/search/widget/result_search_screen.dart';
import 'package:foodcompass_application/widgets/global_loading_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SearchHomeScreen extends StatefulWidget {
  final String searchQuery;
  const SearchHomeScreen({
    super.key,
    required this.searchQuery,
  });

  @override
  State<SearchHomeScreen> createState() => _SearchHomeScreenState();
}

class _SearchHomeScreenState extends State<SearchHomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeScreenProvider>(context, listen: false)
          .performSearch(widget.searchQuery);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Food',
                style: TextStyleConstant.poppinsMedium.copyWith(
                  color: ColorConstant.colorBlack,
                  fontSize: 20.0,
                ),
              ),
              TextSpan(
                text: 'Compass',
                style: TextStyleConstant.poppinsMedium.copyWith(
                  color: ColorConstant.colorOrange,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<HomeScreenProvider>(
        builder: (context, homeScreenProvider, _) {
          final homeScreenProvider = Provider.of<HomeScreenProvider>(context);
          return homeScreenProvider.isLoadingSearch
              ? const Center(
                  child: MyLoading(),
                )
              : homeScreenProvider.isSearched
                  ? homeScreenProvider.searchResults.isNotEmpty
                      ? SearchResultWidget(
                          results: homeScreenProvider.searchResults)
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                LottieConstant.searchNoResult,
                                width: 100,
                                height: 100,
                              ),
                              const SizedBox(height: 10.0),
                              Column(
                                children: [
                                  Text(
                                    'OOPS!',
                                    style: TextStyleConstant.poppinsSemiBold
                                        .copyWith(
                                      color: ColorConstant.colorBlack,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    'Resep yang anda cari tidak ditemukan',
                                    style: TextStyleConstant.poppinsRegular
                                        .copyWith(
                                      color: ColorConstant.colorBlack,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            LottieConstant.searchScreen,
                            width: 200,
                            height: 200,
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Silakan cari terlebih dahulu',
                            style: TextStyleConstant.poppinsRegular.copyWith(
                              color: ColorConstant.colorBlack,
                              fontSize: 12.0,
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
