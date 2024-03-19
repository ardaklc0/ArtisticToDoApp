import 'package:flutter/cupertino.dart';

class KeyboardProvider extends ChangeNotifier {
  bool _isKeyboardVisible = false;
  bool get isKeyboardVisible => _isKeyboardVisible;
  void showKeyboard() {
    _isKeyboardVisible = true;
    notifyListeners();
  }
  void hideKeyboard() {
    _isKeyboardVisible = false;
    notifyListeners();
  }
}