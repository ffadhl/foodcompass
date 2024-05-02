class FoodModel {
  final String id;
  final String name;
  final String image;
  final String aggregateLikes;
  final String readyInMinutes;
  final String servings;
  FoodModel({
    required this.id,
    required this.name,
    required this.image,
    required this.aggregateLikes,
    required this.readyInMinutes,
    required this.servings,
  });
  factory FoodModel.fromJson(json) {
    return FoodModel(
      id: json['id'].toString(),
      name: json['title'] ?? '',
      image: json['image'] ?? '',
      aggregateLikes: json['aggregateLikes'].toString(),
      readyInMinutes: json['readyInMinutes'].toString(),
      servings: json['servings'].toString(),
    );
  }
}

class FoodList {
  final List<FoodModel> list;
  FoodList({
    required this.list,
  });

  factory FoodList.fromJson(List<dynamic> json) {
    return FoodList(
      list: json.map((data) => FoodModel.fromJson(data)).toList(),
    );
  }
}