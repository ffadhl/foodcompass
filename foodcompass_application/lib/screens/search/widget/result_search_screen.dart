import 'package:flutter/material.dart';
import 'package:foodcompass_application/models/search_model.dart';
import 'package:foodcompass_application/screens/search/widget/item_result_search_sceen.dart';

class SearchResultWidget extends StatelessWidget {
  final List<Result> results;

  const SearchResultWidget({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final Result result = results[index];
        return ItemResultSearchWidget(resultSearch: result);
      },
    );
  }
}
