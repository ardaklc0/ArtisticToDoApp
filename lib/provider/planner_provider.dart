import 'package:flutter/cupertino.dart';

class PlannerProvider with ChangeNotifier {
  int? _plannerId;
  List<String> _planners = [];

  int? get plannerId => _plannerId;
  List<String> get planners => _planners;

  void setPlannerId(int value) {
    _plannerId = value;
    notifyListeners();
  }
  void setPlanners(List<String> values) {
    _planners = values;
    notifyListeners();
  }

  void resetPlanner() {
    _plannerId = null;
    notifyListeners();
  }
}