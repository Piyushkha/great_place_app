import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class dbhelper {
  static Future<Database> database() async {
    final dbpath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbpath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'create table user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT )');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await dbhelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await dbhelper.database();
    return db.query(table);
  }
}
