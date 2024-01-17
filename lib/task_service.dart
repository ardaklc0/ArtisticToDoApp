import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:pomodoro2/task_entity.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> initializeDatabase() async {
  String path = join(await getDatabasesPath(), 'task_database.db');
  await deleteDatabase(path);
  return openDatabase(
    path,
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE IF NOT EXISTS tasks(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, creation_date TEXT, task_description TEXT)',
      );
    },
    version: 2,
  );
}
Future<void> insertTask(Task task) async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await initializeDatabase();
  final db = await database;
  await db.insert(
    'tasks',
    task.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
Future<List<Task>> getTasks() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await initializeDatabase();
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query('tasks');
  return List.generate(maps.length, (i) {
    return Task(
      id: maps[i]['id'] as int,
      taskDescription: maps[i]['task_description'] as String,
      creationDate: maps[i]['creation_date'] as String,
    );
  });
}
Future<void> updateTask(Task task) async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await initializeDatabase();
  final db = await database;
  await db.update(
    'tasks',
    task.toMap(),
    where: 'id = ?',
    whereArgs: [task.id],
  );
}
Future<void> deleteTask(int id) async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await initializeDatabase();
  final db = await database;
  await db.delete(
    'tasks',
    where: 'id = ?',
    whereArgs: [id],
  );
}
