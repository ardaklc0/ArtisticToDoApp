import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pomodoro2/ui/helper/common_functions.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../main.dart';
import '../provider/keyboard_provider.dart';
import '../provider/navbar_provider.dart';
import '../ui/widgets/image_container.dart';
//int chosenBackground = Random().nextInt(4) + 2;
//String randomImage =  randomImageChooser("GustavKlimt", 20);
String randomImage =  randomImageChooser("GustavKlimt");
class GustavKlimt extends StatefulWidget {
  const GustavKlimt({super.key, required this.title, this.plannerId, this.date});
  final String title;
  final int? plannerId;
  final String? date;
  @override
  State<GustavKlimt> createState() => _GustavKlimtState();
}
class _GustavKlimtState extends State<GustavKlimt> {
  late Future<SingleChildScrollView> taskFuture;
  late List<Color> colorList;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    colorList = [Colors.transparent, Colors.transparent];
    _loadColors();
  }

  Future<void> _loadColors() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      List<Color> colors = await sortedColors(randomImage);
      setState(() {
        colorList = colors;
        taskFuture = createPlanner(
          widget.date!,
          widget.plannerId!,
          colorList.last,
          colorList.elementAt(chosenBackground),
          Colors.black,
        );
        isLoading = false;
      });
    } catch (error) {
      print('Error loading colors: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    final navbarProvider = Provider.of<NavbarProvider>(context);
    final keyboardProvider = Provider.of<KeyboardProvider>(context, listen: false);
    final viewInsets = EdgeInsets.fromViewPadding(WidgetsBinding.instance.window.viewInsets,WidgetsBinding.instance.window.devicePixelRatio);
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          navbarProvider.showNavbar();
          keyboardProvider.hideKeyboard();
        }
      },
      child: Scaffold(
        appBar: ShimmerAppBar(
          isLoading: isLoading,
          colorList: colorList,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                navbarProvider.showNavbar();
                keyboardProvider.hideKeyboard();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        backgroundColor: colorList.last,
        resizeToAvoidBottomInset: true,
        body:  AnimatedPadding(
            duration: const Duration(milliseconds: 150),
            padding: EdgeInsets.only(
              bottom: keyboardProvider.isKeyboardVisible ? viewInsets.bottom : 0,
            ),
            child: _buildBody(deviceWidth, deviceHeight)
        ),
      ),
    );
  }

  Widget _buildBody(double deviceWidth, double deviceHeight) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ImageContainer(
          imageUrl: randomImage,
          imageAlignment: Alignment.center,
        ),
        if (isLoading) const ShimmerLoading(
          isLoading: true,
          child: PlaceholderForPage(),
        ) else
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: FutureBuilder<SingleChildScrollView>(
                    future: taskFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return snapshot.data ?? Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}