import 'dart:convert';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  List<Result> results;
  int offset;
  int number;
  int totalResults;

  SearchModel({
    required this.results,
    required this.offset,
    required this.number,
    required this.totalResults,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        offset: json["offset"] ?? 0,
        number: json["number"] ?? 0,
        totalResults: json["totalResults"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "offset": offset,
        "number": number,
        "totalResults": totalResults,
      };
}

class Result {
  int id;
  String title;
  String image;
  String imageType;

  Result({
    required this.id,
    required this.title,
    required this.image,
    required this.imageType,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"] ?? '',
        image: json["image"] ?? '',
        imageType: json["imageType"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "imageType": imageType,
      };
}
