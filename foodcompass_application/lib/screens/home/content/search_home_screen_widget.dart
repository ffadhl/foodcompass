import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/screens/search/search_home_screen/search_home_screen.dart';
import 'package:foodcompass_application/widgets/global_search_bar_widget.dart';

class SearchHomeScreenWidget extends StatefulWidget {
  final GlobalKey<FormState> _formKey;
  final TextEditingController _searchBar;

  const SearchHomeScreenWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController searchBar,
  })  : _formKey = formKey,
        _searchBar = searchBar;

  @override
  State<SearchHomeScreenWidget> createState() => _SearchHomeScreenWidgetState();
}

class _SearchHomeScreenWidgetState extends State<SearchHomeScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return GlobalSearchBarWidget(
      key: widget._formKey,
      controller: widget._searchBar,
      hintText: 'Search for food recipes.',
      onSubmitted: (query) {
        if (query.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: ColorConstant.colorOrange20,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OOPS! error: ',
                    style: TextStyleConstant.poppinsSemiBold.copyWith(
                      color: ColorConstant.colorOrange,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    'Please fill in the search form first.',
                    style: TextStyleConstant.poppinsRegular.copyWith(
                      color: ColorConstant.colorOrange,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchHomeScreen(searchQuery: query),
            ),
          );
        }
        widget._searchBar.clear();
      },
    );
  }
}
