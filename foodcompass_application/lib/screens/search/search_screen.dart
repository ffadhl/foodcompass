import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/image_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/providers/search_screen_provider.dart';
import 'package:foodcompass_application/widgets/global_item_food_list_grid.dart';
import 'package:foodcompass_application/screens/search/widget/result_search_screen.dart';
import 'package:foodcompass_application/widgets/global_loading_widget.dart';
import 'package:foodcompass_application/widgets/global_no_data_widget.dart';
import 'package:foodcompass_application/widgets/global_search_bar_widget.dart';
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SearchScreenProvider>(context, listen: false)
          .fetchRandomRecipes();
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
      body: Consumer<SearchScreenProvider>(
          builder: (context, searchScreenProvider, _) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlobalSearchBarWidget(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Image.asset(
                    ImageConstant.rhombusLogo,
                    height: 50.0,
                    width: 50.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Search',
                          style: TextStyleConstant.poppinsSemiBold.copyWith(
                            color: ColorConstant.colorBlack,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          'Food.',
                          style: TextStyleConstant.poppinsRegular.copyWith(
                            color: ColorConstant.colorGrey,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                          : const GlobalNoDataWidget(
                              titleMessage: 'OOPS!',
                              message:
                                  'The recipe you are looking for was not found',
                            )
                      : searchScreenProvider.error != null
                          ? const GlobalNoDataWidget(
                              titleMessage: 'OOPS!',
                              message: 'Something went wrong',
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                              ),
                              itemCount: searchScreenProvider
                                      .randomRecipes?.list.length ??
                                  0,
                              itemBuilder: (context, index) {
                                final randomFood = searchScreenProvider
                                    .randomRecipes!.list[index];
                                return GlobalItemListFoodGridWidget(
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
