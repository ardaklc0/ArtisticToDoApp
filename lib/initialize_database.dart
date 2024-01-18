import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> initializeDatabase() async {
  String path = join(await getDatabasesPath(), 'task_database.db');
  //await deleteDatabase(path);
  return openDatabase(
    path,
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE IF NOT EXISTS planners('
            'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
            'creation_date TEXT,'
            'planner_artist TEXT)',
      );
      await db.execute(
        'CREATE TABLE IF NOT EXISTS tasks('
            'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
            ' creation_date TEXT,'
            ' task_description TEXT,'
            ' planner_id INTEGER)',
      );
    },
    version: 2,
  );
}