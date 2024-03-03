import 'package:flutter/cupertino.dart';

class NavbarProvider extends ChangeNotifier {
  bool navbarState = false;

  void hideNavbar() {
    navbarState = true;
    notifyListeners();
  }

  void showNavbar() {
    navbarState = false;
    notifyListeners();
  }

  bool get getNavbarVisibility => navbarState;

}