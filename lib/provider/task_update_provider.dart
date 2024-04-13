import 'package:flutter/foundation.dart';

class TaskUpdateProvider extends ChangeNotifier {
  void taskUpdated() {
    notifyListeners();
  }
}