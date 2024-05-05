import 'dart:convert';

DetailNutritionModel detailNutritionModelFromJson(String str) =>
    DetailNutritionModel.fromJson(json.decode(str));

String detailNutritionModelToJson(DetailNutritionModel data) =>
    json.encode(data.toJson());

class DetailNutritionModel {
  String calories;
  String carbs;
  String fat;
  String protein;
  List<Bad> bad;
  List<Bad> good;
  List<Flavonoid> nutrients;
  List<Flavonoid> properties;
  List<Flavonoid> flavonoids;
  List<Ingredient> ingredients;
  CaloricBreakdown caloricBreakdown;
  WeightPerServing weightPerServing;
  int expires;
  bool isStale;

  DetailNutritionModel({
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.protein,
    required this.bad,
    required this.good,
    required this.nutrients,
    required this.properties,
    required this.flavonoids,
    required this.ingredients,
    required this.caloricBreakdown,
    required this.weightPerServing,
    required this.expires,
    required this.isStale,
  });

  factory DetailNutritionModel.fromJson(Map<String, dynamic> json) =>
      DetailNutritionModel(
        calories: json["calories"],
        carbs: json["carbs"],
        fat: json["fat"],
        protein: json["protein"],
        bad: List<Bad>.from(json["bad"].map((x) => Bad.fromJson(x))),
        good: List<Bad>.from(json["good"].map((x) => Bad.fromJson(x))),
        nutrients: List<Flavonoid>.from(
            json["nutrients"].map((x) => Flavonoid.fromJson(x))),
        properties: List<Flavonoid>.from(
            json["properties"].map((x) => Flavonoid.fromJson(x))),
        flavonoids: List<Flavonoid>.from(
            json["flavonoids"].map((x) => Flavonoid.fromJson(x))),
        ingredients: List<Ingredient>.from(
            json["ingredients"].map((x) => Ingredient.fromJson(x))),
        caloricBreakdown: CaloricBreakdown.fromJson(json["caloricBreakdown"]),
        weightPerServing: WeightPerServing.fromJson(json["weightPerServing"]),
        expires: json["expires"],
        isStale: json["isStale"],
      );

  Map<String, dynamic> toJson() => {
        "calories": calories,
        "carbs": carbs,
        "fat": fat,
        "protein": protein,
        "bad": List<dynamic>.from(bad.map((x) => x.toJson())),
        "good": List<dynamic>.from(good.map((x) => x.toJson())),
        "nutrients": List<dynamic>.from(nutrients.map((x) => x.toJson())),
        "properties": List<dynamic>.from(properties.map((x) => x.toJson())),
        "flavonoids": List<dynamic>.from(flavonoids.map((x) => x.toJson())),
        "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
        "caloricBreakdown": caloricBreakdown.toJson(),
        "weightPerServing": weightPerServing.toJson(),
        "expires": expires,
        "isStale": isStale,
      };
}

class Bad {
  String amount;
  bool indented;
  String title;
  double percentOfDailyNeeds;

  Bad({
    required this.amount,
    required this.indented,
    required this.title,
    required this.percentOfDailyNeeds,
  });

  factory Bad.fromJson(Map<String, dynamic> json) => Bad(
        amount: json["amount"],
        indented: json["indented"],
        title: json["title"],
        percentOfDailyNeeds: json["percentOfDailyNeeds"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "indented": indented,
        "title": title,
        "percentOfDailyNeeds": percentOfDailyNeeds,
      };
}

class CaloricBreakdown {
  double percentFat;
  double percentCarbs;
  double percentProtein;

  CaloricBreakdown({
    required this.percentFat,
    required this.percentCarbs,
    required this.percentProtein,
  });

  factory CaloricBreakdown.fromJson(Map<String, dynamic> json) =>
      CaloricBreakdown(
        percentFat: json["percentFat"]?.toDouble(),
        percentCarbs: json["percentCarbs"]?.toDouble(),
        percentProtein: json["percentProtein"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "percentFat": percentFat,
        "percentCarbs": percentCarbs,
        "percentProtein": percentProtein,
      };
}

class Flavonoid {
  String name;
  double amount;
  Unit unit;
  double? percentOfDailyNeeds;

  Flavonoid({
    required this.name,
    required this.amount,
    required this.unit,
    this.percentOfDailyNeeds,
  });

  factory Flavonoid.fromJson(Map<String, dynamic> json) => Flavonoid(
        name: json["name"],
        amount: json["amount"]?.toDouble(),
        unit: unitValues.map[json["unit"]]!,
        percentOfDailyNeeds: json["percentOfDailyNeeds"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
        "unit": unitValues.reverse[unit],
        "percentOfDailyNeeds": percentOfDailyNeeds,
      };
}

enum Unit { EMPTY, G, IU, KCAL, MG, UNIT, UNIT_G }

final unitValues = EnumValues({
  "": Unit.EMPTY,
  "g": Unit.G,
  "IU": Unit.IU,
  "kcal": Unit.KCAL,
  "mg": Unit.MG,
  "%": Unit.UNIT,
  "µg": Unit.UNIT_G
});

class Ingredient {
  String name;
  double amount;
  String unit;
  int id;
  List<Flavonoid> nutrients;

  Ingredient({
    required this.name,
    required this.amount,
    required this.unit,
    required this.id,
    required this.nutrients,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        name: json["name"],
        amount: json["amount"]?.toDouble(),
        unit: json["unit"],
        id: json["id"],
        nutrients: List<Flavonoid>.from(
            json["nutrients"].map((x) => Flavonoid.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
        "unit": unit,
        "id": id,
        "nutrients": List<dynamic>.from(nutrients.map((x) => x.toJson())),
      };
}

class WeightPerServing {
  int amount;
  Unit unit;

  WeightPerServing({
    required this.amount,
    required this.unit,
  });

  factory WeightPerServing.fromJson(Map<String, dynamic> json) =>
      WeightPerServing(
        amount: json["amount"],
        unit: unitValues.map[json["unit"]]!,
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "unit": unitValues.reverse[unit],
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
