import 'package:flutter/material.dart';

import '../models/task_model.dart';

class TaskProvider with ChangeNotifier {
  static int? _taskId;
  List<Task> _tasks = [];
  Color? _prioColor = Colors.black;
  double _initialOffset = 0.0;

  static int? get taskId => _taskId;
  List<Task> get tasks => _tasks;
  Color? get prioColor => _prioColor;
  double get initialOffset => _initialOffset;

  void setInitialOffset(double value) {
    _initialOffset = value;
    notifyListeners();
  }
  void setPrioColor(Color value) {
    _prioColor = value;
    notifyListeners();
  }
  void setTasks(List<Task> tasks) {
    _tasks = tasks;
    notifyListeners();
  }
  void setTaskId(int value) {
    _taskId = value;
    notifyListeners();
  }
  void resetTask() {
    _taskId = null;
    notifyListeners();
  }
  void resetTasks() {
    _tasks = [];
    notifyListeners();
  }
}