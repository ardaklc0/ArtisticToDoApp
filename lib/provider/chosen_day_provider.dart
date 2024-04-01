import 'package:flutter/cupertino.dart';

class ChosenDayProvider extends ChangeNotifier {
  Set<String> _chosenDay = {};

  Set<String> get chosenDay => _chosenDay;

  void setChosenDay(Set<String> days) {
    _chosenDay = days;
    notifyListeners();
  }
  void clearChosenDay() {
    _chosenDay = {};
    notifyListeners();
  }
}