class FavoriteRecipe {
  final String id;
  final String title;
  final String image;
  final String aggregateLikes;
  final String readyInMinutes;
  final String servings;
  bool isFavorite;

  FavoriteRecipe({
    required this.id,
    required this.title,
    required this.image,
    required this.aggregateLikes,
    required this.readyInMinutes,
    required this.servings,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'aggregateLikes': aggregateLikes,
      'readyInMinutes': readyInMinutes,
      'servings': servings,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory FavoriteRecipe.fromMap(Map<String, dynamic> map) {
    return FavoriteRecipe(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      aggregateLikes: map['aggregateLikes'] ?? '',
      readyInMinutes: map['readyInMinutes'] ?? '',
      servings: map['servings'] ?? '',
      isFavorite: map['isFavorite'] == 1,
    );
  }
}
