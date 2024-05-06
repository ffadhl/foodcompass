import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/models/failure_model.dart';
import 'package:foodcompass_application/models/search_model.dart';
import 'package:foodcompass_application/screens/search/widget/result_search_screen.dart';
import 'package:foodcompass_application/services/api/spoonacular_api.dart';
import 'package:foodcompass_application/widgets/loading_widget.dart';

class SearchHomeScreen extends StatefulWidget {
  final String searchQuery;
  const SearchHomeScreen({super.key, required this.searchQuery});

  @override
  State<SearchHomeScreen> createState() => _SearchHomeScreenState();
}

class _SearchHomeScreenState extends State<SearchHomeScreen> {
  List<Result> _searchResults = [];
  bool _isLoading = false;

  Future<void> _performSearch(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final searchResults = await SpoonacularApi().getSearch(query, 10);
      setState(() {
        _searchResults = searchResults.results;
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
  void initState() {
    _performSearch(widget.searchQuery);
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
      body: Expanded(
        child: _isLoading
            ? const Center(
                child: MyLoading(),
              )
            : _searchResults.isNotEmpty
                ? SearchResultWidget(results: _searchResults)
                : const Center(
                    child: Text('No results found. Please try again.'),
                  ),
      ),
    );
  }
}
