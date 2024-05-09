import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/lottie_animation_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/providers/search_screen_provider.dart';
import 'package:foodcompass_application/screens/search/widget/result_search_screen.dart';
import 'package:foodcompass_application/widgets/loading_widget.dart';
import 'package:foodcompass_application/widgets/no_data_global_widget.dart';
import 'package:foodcompass_application/widgets/search_bar_global_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _searchBar = TextEditingController();

  @override
  void dispose() {
    _searchBar.dispose();
    super.dispose();
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
      body: Consumer<SearchScreenProvider>(
          builder: (context, searchScreenProvider, _) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SearchBarWidget(
                key: _formKey,
                controller: _searchBar,
                hintText: 'Cari resep makanan',
                onSubmitted: (query) {
                  if (query.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: ColorConstant.colorOrange20,
                        content: Text(
                          'Mohon untuk di-isi form searchnya terlebih dahulu :)',
                          style: TextStyleConstant.poppinsRegular.copyWith(
                            color: ColorConstant.colorOrange,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    );
                  } else {
                    searchScreenProvider.performSearch(query);
                    _searchBar.clear();
                  }
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: searchScreenProvider.isLoading
                    ? const Center(
                        child: MyLoading(),
                      )
                    : searchScreenProvider.isSearched
                        ? searchScreenProvider.searchResults.isNotEmpty
                            ? SearchResultWidget(
                                results: searchScreenProvider.searchResults)
                            : const NoDataWidget(
                                titleMessage: 'OOPS!',
                                message:
                                    'The recipe you are looking for was not found',
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
                                Column(
                                  children: [
                                    Text(
                                      'Search Information:',
                                      style: TextStyleConstant.poppinsSemiBold
                                          .copyWith(
                                        color: ColorConstant.colorBlack,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Text(
                                      'Please search first',
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
                          ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
