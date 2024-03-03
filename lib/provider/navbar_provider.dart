import 'package:flutter/cupertino.dart';

class NavbarProvider extends ChangeNotifier {
  bool _navbarState = false;
  int _currentIndex = 0;

  void hideNavbar() {
    _navbarState = true;
    notifyListeners();
  }

  void showNavbar() {
    _navbarState = false;
    notifyListeners();
  }

  void setInitialIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }


  bool get getNavbarVisibility => _navbarState;
  int get getInitialIndex => _currentIndex;

}