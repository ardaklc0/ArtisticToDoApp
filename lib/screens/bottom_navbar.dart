import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:pomodoro2/screens/created_planners.dart';
import 'package:pomodoro2/screens/gallery.dart';
import 'package:provider/provider.dart';
import '../provider/navbar_provider.dart';
import 'home_page_test.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    PersistentTabController controller;
    final navbarProvider = Provider.of<NavbarProvider>(context);
    controller = PersistentTabController(initialIndex: 0);

    List<Widget> buildScreens() {
      return [
        const CreatedPlanners(),
        const HomePageTest(),
        const Gallery()
      ];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.book, color: Colors.black),
          title: ("Planners"),
          activeColorPrimary: Colors.black,
          textStyle:GoogleFonts.roboto(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
          ),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.add, color: Colors.black),
          title: ("Create"),
          activeColorPrimary: Colors.black,
          textStyle:GoogleFonts.roboto(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
          ),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.brush, color: Colors.black),
          title: ("Gallery"),
          activeColorPrimary: Colors.black,
          textStyle:GoogleFonts.roboto(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
          ),
        )
      ];
    }

    return PersistentTabView(
      context,
      controller: controller,
      screens: buildScreens(),
      items: navBarsItems(),
      confineToSafeArea: true,
      backgroundColor:Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: false,
      hideNavigationBarWhenKeyboardAppears: true,
      decoration: const NavBarDecoration(
        colorBehindNavBar: Colors.white,
      ),
      isVisible: navbarProvider.getNavbarVisibility,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
      ),
      navBarStyle: NavBarStyle.style9,
    );
  }
}
class CustomNavbar extends StatelessWidget {
  const CustomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavBar(),
    );
  }
}