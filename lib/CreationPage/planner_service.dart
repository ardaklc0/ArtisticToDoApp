import 'package:flutter/cupertino.dart';
import 'package:pomodoro2/CreationPage/planner_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../initialize_database.dart';


laFuture<int> insertPlanner(Planner planner) async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await initializeDatabase();
  final db = await database;
  return await db.insert(
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
Future<Planner?> getPlanner(int plannerId) async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await initializeDatabase();
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(
    'planners',
    where: 'id = ?',
    whereArgs: [plannerId],
  );
  if (maps.isNotEmpty) {
    return Planner(
      id: maps[0]['id'] as int,
      creationDate: maps[0]['creation_date'] as String,
      plannerArtist: maps[0]['planner_artist'] as String,
    );
  } else {
    return null;
  }
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