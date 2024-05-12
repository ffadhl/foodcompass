import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/models/failure_model.dart';
import 'package:foodcompass_application/models/food_model.dart';
import 'package:foodcompass_application/providers/search_screen_provider.dart';
import 'package:foodcompass_application/screens/home/more/widget/item_food_list_more_grid.dart';
import 'package:foodcompass_application/screens/search/widget/result_search_screen.dart';
import 'package:foodcompass_application/services/api/spoonacular_api.dart';
import 'package:foodcompass_application/widgets/loading_widget.dart';
import 'package:foodcompass_application/widgets/no_data_global_widget.dart';
import 'package:foodcompass_application/widgets/search_bar_global_widget.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _searchBar = TextEditingController();
  FoodList? _randomRecipes;

  @override
  void dispose() {
    _searchBar.dispose();
    super.dispose();
  }

  Future<void> _fetchRandomRecipes() async {
    final spoonacularApi = SpoonacularApi();
    try {
      _randomRecipes ??= await spoonacularApi.getRandom(25);
      setState(() {
        _randomRecipes = _randomRecipes;
      });
    } on FailureMessage catch (e) {
      print(e.message);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    _fetchRandomRecipes();
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
      body: Consumer<SearchScreenProvider>(
          builder: (context, searchScreenProvider, _) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SearchBarWidget(
                key: _formKey,
                controller: _searchBar,
                hintText: 'Search for food recipes...',
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
                      : // use gridview.builder
                      GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: _randomRecipes?.list.length ?? 0,
                          itemBuilder: (context, index) {
                            final randomFood = _randomRecipes!.list[index];
                            return ItemListFoodMoreGridWidget(
                              food: randomFood,
                            );
                          },
                        ),
            ),
          ],
        );
      }),
    );
  }
}
