import 'dart:convert';

List<DetailSimilarModel> detailSimilarModelFromJson(String str) =>
    List<DetailSimilarModel>.from(
        json.decode(str).map((x) => DetailSimilarModel.fromJson(x)));

String detailSimilarModelToJson(List<DetailSimilarModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DetailSimilarModel {
  int id;
  String imageType;
  String title;
  int readyInMinutes;
  int servings;
  String sourceUrl;

  DetailSimilarModel({
    required this.id,
    required this.imageType,
    required this.title,
    required this.readyInMinutes,
    required this.servings,
    required this.sourceUrl,
  });

  factory DetailSimilarModel.fromJson(Map<String, dynamic> json) =>
      DetailSimilarModel(
        id: json["id"],
        imageType: json["imageType"],
        title: json["title"],
        readyInMinutes: json["readyInMinutes"],
        servings: json["servings"],
        sourceUrl: json["sourceUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imageType": imageType,
        "title": title,
        "readyInMinutes": readyInMinutes,
        "servings": servings,
        "sourceUrl": sourceUrl,
      };
}

class SimilarFoodList {
  final List<DetailSimilarModel> list;
  SimilarFoodList({
    required this.list,
  });

  factory SimilarFoodList.fromJson(List<dynamic> json) {
    return SimilarFoodList(
      list: json.map((data) => DetailSimilarModel.fromJson(data)).toList(),
    );
  }
}
