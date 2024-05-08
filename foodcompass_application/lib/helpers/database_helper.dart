import 'package:foodcompass_application/models/favorite_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }
  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  final String _tableName = 'favorite';

  Future<Database> _initializeDb() async {
    var db = openDatabase(
      join(
        await getDatabasesPath(),
        'favorite_db.db',
      ),
      onCreate: (db, version) async {
        await db.execute(
          '''
        CREATE TABLE $_tableName(
          id TEXT PRIMARY KEY,
          title TEXT,
          image TEXT,
          aggregateLikes TEXT,
          readyInMinutes TEXT,
          servings TEXT,
          isFavorite INTEGER
        )
        ''',
        );
      },
      version: 1,
    );
    return db;
  }

  Future<void> addFavoriteRecipe(FavoriteRecipe recipe) async {
    Database db = await database;
    await db.insert(_tableName, recipe.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<FavoriteRecipe>> getAllFavoriteRecipes() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return FavoriteRecipe.fromMap(maps[i]);
    });
  }

  Future<void> updateFavoriteStatus(String id, bool isFavorite) async {
    Database db = await database;
    await db.update(
      _tableName,
      {'isFavorite': isFavorite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> removeFavoriteRecipe(String id) async {
    Database db = await database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
