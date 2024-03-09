import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom_navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future<void>.delayed(const Duration(milliseconds: 750), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomNavbar()));
    });
    super.initState();
  }
  @override
  Widget build(final BuildContext context) {
    return Container(
      color: Colors.white, // Set the background color to white
      child: Center(
        child: Hero(
          tag: "logo",
          child: Image.asset(
            'assets/images/planart.png',
            height: MediaQuery.of(context).size.height / 4,
          ),
        ),
      ),
    );
  }
}
