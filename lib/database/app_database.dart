import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  final int version = 1;
  final String databaseName = "superheroes";
  final String tableName = "superheroes";
  Database? db;

  Future<Database> openDb() async {
    db ??= await openDatabase(
      join(await getDatabasesPath(), databaseName),
      version: version,
      onCreate: (db, version) {
        String query = "create table $tableName (id text primary key, name text, gender text, intelligence text, url text)";
        db.execute(query);
      },
    );
    return db as Database;
  }
}