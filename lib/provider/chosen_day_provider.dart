import 'package:flutter/cupertino.dart';

class ChosenDayProvider extends ChangeNotifier {
  List<String> _chosenDay = [];

  List<String> get chosenDay => _chosenDay;

  void setChosenDay(List<String> days) {
    _chosenDay = days;
    notifyListeners();
  }
}