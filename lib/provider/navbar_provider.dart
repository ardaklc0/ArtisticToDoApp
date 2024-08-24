import 'package:flutter/cupertino.dart';

class NavbarProvider extends ChangeNotifier {
  bool _navbarState = true;
  int _currentIndex = 0;

  void hideNavbar() {
    _navbarState = false;
    notifyListeners();
  }

  void showNavbar() {
    _navbarState = true;
    notifyListeners();
  }

  void setInitialIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }


  bool get getNavbarVisibility => _navbarState;
  int get getInitialIndex => _currentIndex;

}