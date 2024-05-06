import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/models/failure_model.dart';
import 'package:foodcompass_application/models/search_model.dart';
import 'package:foodcompass_application/screens/search/widget/result_search_screen.dart';
import 'package:foodcompass_application/services/api/spoonacular_api.dart';
import 'package:foodcompass_application/widgets/loading_widget.dart';
import 'package:foodcompass_application/widgets/search_bar_global_widget.dart';

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
              onSubmitted: (query) => _performSearch(query),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: MyLoading(),
                    )
                  : _searchResults.isNotEmpty
                      ? SearchResultWidget(results: _searchResults)
                      : const Center(
                          child: Text('Tidak ada hasil pencarian'),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
