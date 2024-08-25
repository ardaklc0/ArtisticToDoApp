import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  static int? _taskId;
  List<String> _tasks = [];
  Color? _prioColor = Colors.black;

  static int? get taskId => _taskId;
  List<String> get tasks => _tasks;
  Color? get prioColor => _prioColor;

  void setPrioColor(Color value) {
    _prioColor = value;
    notifyListeners();
  }
  void setTasks(List<String> values) {
    _tasks = values;
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
}