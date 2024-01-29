import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SliderProvider with ChangeNotifier {
  late SharedPreferences _sharedPreferences;

  static late int _studyDurationSliderValue;


  static int get studyDurationSliderValue => _studyDurationSliderValue;


  SliderProvider() {
    loadSliderFromSharedPref();
  }

  void updateWorkDurationSliderValue(int newValue) {
    _studyDurationSliderValue = newValue;
    saveSliderToSharedPref(
        'studyDurationSliderValue', _studyDurationSliderValue);

    notifyListeners();
  }


  Future<void> createSharedPrefObject() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void saveSliderToSharedPref(String key, int value) {
    _sharedPreferences.setInt(key, value);
  }

  Future<void> loadSliderFromSharedPref() async {
    await createSharedPrefObject();
    _studyDurationSliderValue =
        _sharedPreferences.getInt('studyDurationSliderValue') ?? 25;


    notifyListeners();
  }
}