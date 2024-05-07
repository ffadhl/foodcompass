import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/lottie_animation_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/models/failure_model.dart';
import 'package:foodcompass_application/models/search_model.dart';
import 'package:foodcompass_application/screens/search/widget/result_search_screen.dart';
import 'package:foodcompass_application/services/api/spoonacular_api.dart';
import 'package:foodcompass_application/widgets/loading_widget.dart';
import 'package:foodcompass_application/widgets/search_bar_global_widget.dart';
import 'package:lottie/lottie.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _searchBar = TextEditingController();
  List<Result> _searchResults = [];
  bool _isLoading = false;
  bool _isSearched = false;

  @override
  void dispose() {
    _searchBar.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final searchResults = await SpoonacularApi().getSearch(query, 10);
      setState(() {
        _searchResults = searchResults.results;
        _isSearched = true;
      });
    } on FailureMessage catch (e) {
      print(e.message);
    } catch (e) {
      print('Error performing search: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
      body: Container(
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
                  _performSearch(query);
                }
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: MyLoading(),
                    )
                  : _isSearched
                      ? _searchResults.isNotEmpty
                          ? SearchResultWidget(results: _searchResults)
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
                                      const SizedBox(height: 5.0),
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
                              Column(
                                children: [
                                  Text(
                                    'Seacrh Information',
                                    style: TextStyleConstant.poppinsSemiBold
                                        .copyWith(
                                      color: ColorConstant.colorBlack,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    'Silakan cari terlebih dahulu',
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
      ),
    );
  }
}
