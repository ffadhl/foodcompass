import 'dart:convert';

DetailRecipeModel detailRecipeModelFromJson(String str) =>
    DetailRecipeModel.fromJson(json.decode(str));

String detailRecipeModelToJson(DetailRecipeModel data) =>
    json.encode(data.toJson());

class DetailRecipeModel {
  bool? vegetarian;
  bool? vegan;
  bool? glutenFree;
  bool? dairyFree;
  bool? veryHealthy;
  bool? cheap;
  bool? veryPopular;
  bool? sustainable;
  int? weightWatcherSmartPoints;
  String? gaps;
  bool? lowFodmap;
  int? aggregateLikes;
  int? spoonacularScore;
  int? healthScore;
  String? creditsText;
  String? license;
  String? sourceName;
  double? pricePerServing;
  List<ExtendedIngredient>? extendedIngredients;
  int? id;
  String? title;
  int? readyInMinutes;
  int? servings;
  String? sourceUrl;
  String? image;
  String? imageType;
  String? summary;
  List<dynamic>? cuisines;
  List<dynamic>? dishTypes;
  List<dynamic>? diets;
  List<dynamic>? occasions;
  String? instructions;
  dynamic originalId;
  String? spoonacularSourceUrl;

  DetailRecipeModel({
    this.vegetarian,
    this.vegan,
    this.glutenFree,
    this.dairyFree,
    this.veryHealthy,
    this.cheap,
    this.veryPopular,
    this.sustainable,
    this.weightWatcherSmartPoints,
    this.gaps,
    this.lowFodmap,
    this.aggregateLikes,
    this.spoonacularScore,
    this.healthScore,
    this.creditsText,
    this.license,
    this.sourceName,
    this.pricePerServing,
    this.extendedIngredients,
    this.id,
    this.title,
    this.readyInMinutes,
    this.servings,
    this.sourceUrl,
    this.image,
    this.imageType,
    this.summary,
    this.cuisines,
    this.dishTypes,
    this.diets,
    this.occasions,
    this.instructions,
    this.originalId,
    this.spoonacularSourceUrl,
  });

  factory DetailRecipeModel.fromJson(dynamic json) => DetailRecipeModel(
        vegetarian: json['vegetarian'] as bool?,
        vegan: json['vegan'] as bool?,
        glutenFree: json['glutenFree'] as bool?,
        dairyFree: json['dairyFree'] as bool?,
        veryHealthy: json['veryHealthy'] as bool?,
        cheap: json['cheap'] as bool?,
        veryPopular: json['veryPopular'] as bool?,
        sustainable: json['sustainable'] as bool?,
        weightWatcherSmartPoints: json['weightWatcherSmartPoints'] as int?,
        gaps: json['gaps'] as String?,
        lowFodmap: json['lowFodmap'] as bool?,
        aggregateLikes: json['aggregateLikes'] as int?,
        spoonacularScore: json['spoonacularScore']?.toInt(),
        healthScore: json['healthScore']?.toInt(),
        creditsText: json['creditsText'] as String?,
        license: json['license'] as String?,
        sourceName: json['sourceName'] as String?,
        pricePerServing: (json['pricePerServing'] as num?)?.toDouble(),
        extendedIngredients: (json['extendedIngredients'] as List<dynamic>?)
            ?.map((e) => ExtendedIngredient.fromJson(e))
            .toList(),
        id: json['id'] as int?,
        title: json['title'] as String?,
        readyInMinutes: json['readyInMinutes'] as int?,
        servings: json['servings'] as int?,
        sourceUrl: json['sourceUrl'] as String?,
        image: json['image'] as String?,
        imageType: json['imageType'] as String?,
        summary: json['summary'] as String?,
        cuisines: json['cuisines'] as List<dynamic>?,
        dishTypes: json['dishTypes'] as List<dynamic>?,
        diets: json['diets'] as List<dynamic>?,
        occasions: json['occasions'] as List<dynamic>?,
        instructions: json['instructions'] as String?,
        originalId: json['originalId'],
        spoonacularSourceUrl: json['spoonacularSourceUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'vegetarian': vegetarian,
        'vegan': vegan,
        'glutenFree': glutenFree,
        'dairyFree': dairyFree,
        'veryHealthy': veryHealthy,
        'cheap': cheap,
        'veryPopular': veryPopular,
        'sustainable': sustainable,
        'weightWatcherSmartPoints': weightWatcherSmartPoints,
        'gaps': gaps,
        'lowFodmap': lowFodmap,
        'aggregateLikes': aggregateLikes,
        'spoonacularScore': spoonacularScore,
        'healthScore': healthScore,
        'creditsText': creditsText,
        'license': license,
        'sourceName': sourceName,
        'pricePerServing': pricePerServing,
        'extendedIngredients':
            extendedIngredients?.map((e) => e.toJson()).toList(),
        'id': id,
        'title': title,
        'readyInMinutes': readyInMinutes,
        'servings': servings,
        'sourceUrl': sourceUrl,
        'image': image,
        'imageType': imageType,
        'summary': summary,
        'cuisines': cuisines,
        'dishTypes': dishTypes,
        'diets': diets,
        'occasions': occasions,
        'instructions': instructions,
        'originalId': originalId,
        'spoonacularSourceUrl': spoonacularSourceUrl,
      };
}

class ExtendedIngredient {
  int? id;
  String? aisle;
  String? image;
  String? consistency;
  String? name;
  String? nameClean;
  String? original;
  String? originalString;
  String? originalName;
  double? amount;
  String? unit;
  List<dynamic>? meta;
  List<dynamic>? metaInformation;
  Measures? measures;

  ExtendedIngredient({
    this.id,
    this.aisle,
    this.image,
    this.consistency,
    this.name,
    this.nameClean,
    this.original,
    this.originalString,
    this.originalName,
    this.amount,
    this.unit,
    this.meta,
    this.metaInformation,
    this.measures,
  });

  factory ExtendedIngredient.fromJson(dynamic json) {
    return ExtendedIngredient(
      id: json['id'] as int?,
      aisle: json['aisle'] as String?,
      image: json['image'] as String?,
      consistency: json['consistency'] as String?,
      name: json['name'] as String?,
      nameClean: json['nameClean'] as String?,
      original: json['original'] as String?,
      originalString: json['originalString'] as String?,
      originalName: json['originalName'] as String?,
      amount: json['amount']?.toDouble(),
      unit: json['unit'] as String?,
      meta: json['meta'] as List<dynamic>?,
      metaInformation: json['metaInformation'] as List<dynamic>?,
      measures:
          json['measures'] == null ? null : Measures.fromJson(json['measures']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'aisle': aisle,
        'image': image,
        'consistency': consistency,
        'name': name,
        'nameClean': nameClean,
        'original': original,
        'originalString': originalString,
        'originalName': originalName,
        'amount': amount,
        'unit': unit,
        'meta': meta,
        'metaInformation': metaInformation,
        'measures': measures?.toJson(),
      };
}

class Measures {
  Metric? us;
  Metric? metric;

  Measures({this.us, this.metric});

  factory Measures.fromJson(dynamic json) => Measures(
        us: json['us'] == null ? null : Metric.fromJson(json['us']),
        metric: json['metric'] == null ? null : Metric.fromJson(json['metric']),
      );

  Map<String, dynamic> toJson() => {
        'us': us?.toJson(),
        'metric': metric?.toJson(),
      };
}

class Metric {
  double? amount;
  String? unitShort;
  String? unitLong;

  Metric({this.amount, this.unitShort, this.unitLong});

  factory Metric.fromJson(dynamic json) => Metric(
        amount: (json['amount'] as num?)?.toDouble(),
        unitShort: json['unitShort'] as String?,
        unitLong: json['unitLong'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'unitShort': unitShort,
        'unitLong': unitLong,
      };
}
