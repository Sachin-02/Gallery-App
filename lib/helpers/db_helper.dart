import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  DBHelper._();
  static final DBHelper db = DBHelper._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, "pages.db"),
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE IF NOT EXISTS pages(
              id TEXT PRIMARY KEY, 
              name TEXT,
              image TEXT
              )''');
        await db.execute('''CREATE TABLE IF NOT EXISTS images(
              id TEXT PRIMARY KEY, 
              pageId TEXT,  
              image TEXT,
              FOREIGN KEY(pageId) REFERENCES pages
              )''');
      },
      onConfigure: (db) {
        db.execute("PRAGMA foreign_keys = ON");
      },
      version: 1,
    );
  }

  Future<void> insert(String tableName, Map<String, Object> data) async {
    final db = _database;
    await db.insert(tableName, data);
  }

  Future<List<Map<String, dynamic>>> getAllData(String table) async {
    final db = await database;
    return db.query(table);
  }

  Future<void> update(
      {String table,
      String columnId,
      String whereColumnId,
      String setArg,
      String whereArg}) async {
    final db = await database;
    await db.rawUpdate(
        "UPDATE $table SET $columnId = ? WHERE $whereColumnId = ?",
        [setArg, whereArg]);
  }

  Future<void> delete({String table, String columnId, String whereArg}) async {
    final db = await database;
    await db.delete(table, where: "$columnId = ?", whereArgs: [whereArg]);
  }
}
