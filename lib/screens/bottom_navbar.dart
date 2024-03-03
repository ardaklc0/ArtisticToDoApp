import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:pomodoro2/screens/created_planners.dart';
import 'package:pomodoro2/ui/helper/common_functions.dart';
import 'package:provider/provider.dart';

import '../provider/navbar_provider.dart';
import 'home_page.dart';
import 'home_page_test.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    PersistentTabController controller;
    controller = PersistentTabController(initialIndex: 0);
    final navbarProvider = Provider.of<NavbarProvider>(context);

    List<Widget> _buildScreens() {
      return [
        const HomePageTest(),
        const CreatedPlanners(),
        const HomePage()
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
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
          icon: const Icon(Icons.book, color: Colors.black),
          title: ("Planners"),
          activeColorPrimary: Colors.black,
          textStyle:GoogleFonts.roboto(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
          ),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.place_outlined, color: Colors.black),
          title: ("Planners"),
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
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor:Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: false,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: const NavBarDecoration(
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style9,
      hideNavigationBar: navbarProvider.getNavbarVisibility,

    );
  }
}
class CustomNavbar extends StatelessWidget {
  const CustomNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavBar(),
    );
  }
}