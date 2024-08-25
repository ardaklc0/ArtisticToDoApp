import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
Future<Database> initializeDatabase() async {
  try {
    var databasesPath = await getApplicationDocumentsDirectory();
    //await deleteDatabase(p.join(databasesPath.path, 'task_database.db'));
    String path = p.join(databasesPath.path, 'task_database.db');
    Database database = await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE IF NOT EXISTS planners'
              '('
              'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
              'creation_date TEXT,'
              'planner_artist TEXT)',
        );
        await db.execute(
          'CREATE TABLE IF NOT EXISTS tasks'
              '(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
              'creation_date TEXT,'
              'task_description TEXT,'
              'planner_id INTEGER,'
              'priority INT,'
              'is_done INT,'
              'total_work_minutes INT)',
        );
      },
      version: 4,
    );
    return database;
  } catch (e) {
    debugPrint('Error: $e');
    rethrow;
  }
}
