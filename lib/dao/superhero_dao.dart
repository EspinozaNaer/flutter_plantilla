import 'package:superheroes/database/app_database.dart';
import 'package:superheroes/model/superhero.dart';
import 'package:sqflite/sqlite_api.dart';

class SuperHeroDao {
  Future<void> insert(Superhero superhero) async {
    Database db = await AppDatabase().openDb();
    List<Map<String, dynamic>> existing = await db.query(
      AppDatabase().tableName,
      where: "id = ?",
      whereArgs: [superhero.id],
    );

    if (existing.isEmpty) {
      await db.insert(AppDatabase().tableName, superhero.toMap());
    } else {
      await db.update(AppDatabase().tableName, superhero.toMap(), where: "id = ?", whereArgs: [superhero.id],);
    }
  }

  Future<void> delete(Superhero superhero) async {
    Database db = await AppDatabase().openDb();
    await db.delete(AppDatabase().tableName, where: "id = ?", whereArgs: [superhero.id]);
  }

  Future<bool> isFavorite(Superhero superhero) async {
    Database db = await AppDatabase().openDb();
    List<Map<String, dynamic>> maps = await db.query(
      AppDatabase().tableName,
      where: "id = ?",
      whereArgs: [superhero.id],
    );
    return maps.isNotEmpty;
  }

  Future<List<Superhero>> getAll() async {
    Database db = await AppDatabase().openDb();
    List<Map<String, dynamic>> maps = await db.query(AppDatabase().tableName);
    return maps.map((map) => Superhero.fromMap(map)).toList();
  }
}