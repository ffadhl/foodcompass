class DetailSimilarModel {
  final String id;
  final String name;
  final String imageType;
  final String readyInMinutes;
  final String servings;

  DetailSimilarModel({
    required this.id,
    required this.name,
    required this.imageType,
    required this.readyInMinutes,
    required this.servings,
  });

  factory DetailSimilarModel.fromJson(json) {
    return DetailSimilarModel(
      id: json['id'].toString() ,
      name: json['title'] ?? '',
      imageType: json['imageType'] ?? '',
      readyInMinutes: json['readyInMinutes'].toString(),
      servings: json['servings'].toString(),
    );
  }
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
