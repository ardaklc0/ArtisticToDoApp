import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:pomodoro2/models/task_model.dart';
import 'package:pomodoro2/services/initialize_database.dart';
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
      plannerId: maps[i]['planner_id'] as int,
      isDone: maps[i]['is_done'] as int,
      totalWorkMinutes: maps[i]['total_work_minutes'] as int
    );
  });
}
Future<List<Task>> getUncheckedTasks(int plannerId) async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await initializeDatabase();
  final db = database;
  final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: "planner_id = ? AND is_done = 0",
      whereArgs: [plannerId]
  );
  return List.generate(maps.length, (i) {
    return Task(
        id: maps[i]['id'] as int,
        taskDescription: maps[i]['task_description'] as String,
        creationDate: maps[i]['creation_date'] as String,
        plannerId: maps[i]['planner_id'] as int,
        isDone: maps[i]['is_done'] as int,
        totalWorkMinutes: maps[i]['total_work_minutes'] as int
    );
  });
}
Future<Task?> getTask(int taskId) async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await initializeDatabase();
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(
    'tasks',
    where: 'id = ?',
    whereArgs: [taskId],
  );
  if (maps.isNotEmpty) {
    return Task(
      id: maps[0]['id'] as int,
      taskDescription: maps[0]['task_description'] as String,
      creationDate: maps[0]['creation_date'] as String,
      plannerId: maps[0]['planner_id'] as int,
      isDone: maps[0]['is_done'] as int,
      totalWorkMinutes: maps[0]['total_work_minutes'] as int
    );
  } else {
    return null;
  }
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
