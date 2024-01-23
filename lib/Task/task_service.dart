import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:pomodoro2/Task/task_entity.dart';
import 'package:pomodoro2/initialize_database.dart';
import 'package:sqflite/sqflite.dart';

Future<int> insertTask(Task task) async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await initializeDatabase();
  final db = database;
  return await db.insert(
    'tasks',
    task.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
Future<List<Task>> getTasks(int plannerId) async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await initializeDatabase();
  final db = database;
  final List<Map<String, dynamic>> maps = await db.query(
    'tasks',
    where: "planner_id = ?",
    whereArgs: [plannerId]
  );
  return List.generate(maps.length, (i) {
    return Task(
      id: maps[i]['id'] as int,
      taskDescription: maps[i]['task_description'] as String,
      creationDate: maps[i]['creation_date'] as String,
      plannerId: maps[i]['planner_id'] as int, // Corrected column name
    );
  });
}
Future<int> updateTask(Task task) async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await initializeDatabase();
  final db = database;
  return await db.update(
    'tasks',
    task.toMap(),
    where: 'id = ?',
    whereArgs: [task.id],
  );
}
Future<void> deleteTask(int id) async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await initializeDatabase();
  final db = database;
  await db.delete(
    'tasks',
    where: 'id = ?',
    whereArgs: [id],
  );
}
