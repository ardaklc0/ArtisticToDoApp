import 'package:flutter/cupertino.dart';
import 'package:pomodoro2/CreationPage/planner_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> initializeDatabase() async {
  String path = join(await getDatabasesPath(), 'task_database.db');
  //await deleteDatabase(path);
  return openDatabase(
    path,
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE IF NOT EXISTS planners(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, creation_date TEXT, planner_artist TEXT)',
      );
    },
    version: 2,
  );
}
Future<void> insertPlanner(Planner planner) async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await initializeDatabase();
  final db = await database;
  await db.insert(
    'planners',
    planner.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace);
}
Future<List<Planner>> getPlanners() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await initializeDatabase();
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query('planners');
  return List.generate(maps.length, (i) {
    return Planner(
        id: maps[i]['id'] as int,
        creationDate: maps[i]['creation_date'] as String,
        plannerArtist: maps[i]['planner_artist'] as String
    );
  });
}
Future<void> updatePlanner(Planner planner) async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await initializeDatabase();
  final db = await database;
  await db.update(
    'planners',
    planner.toMap(),
    where: 'id = ?',
    whereArgs: [planner.id],
  );
}
Future<void> deletePlanner(int id) async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await initializeDatabase();
  final db = await database;
  await db.delete(
    'planners',
    where: 'id = ?',
    whereArgs: [id],
  );
}