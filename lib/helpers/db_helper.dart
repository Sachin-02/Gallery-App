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
              title TEXT,
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
}
