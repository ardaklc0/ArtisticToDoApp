import 'package:flutter/cupertino.dart';

class TaskProvider with ChangeNotifier {
  int? _taskId;
  List<String> _tasks = [];

  int? get taskId => _taskId;
  List<String> get tasks => _tasks;

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