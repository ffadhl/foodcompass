import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/models/search_model.dart';
import 'package:foodcompass_application/screens/detail/detail_screen.dart';

class ItemResultSearchWidget extends StatefulWidget {
  final Result resultSearch;
  const ItemResultSearchWidget({
    super.key,
    required this.resultSearch,
  });

  @override
  State<ItemResultSearchWidget> createState() => _ItemResultSearchWidgetState();
}

class _ItemResultSearchWidgetState extends State<ItemResultSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstant.colorWhite,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: ColorConstant.colorGrey50,
              offset: Offset(0, 0),
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                widget.resultSearch.image,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              widget.resultSearch.title,
              style: TextStyleConstant.poppinsRegular.copyWith(
                fontSize: 14.0,
                color: ColorConstant.colorBlack,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    id: widget.resultSearch.id.toString(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
