import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../main.dart';
import '../provider/navbar_provider.dart';
import '../ui/helper/common_functions.dart';
import '../ui/widgets/common_widgets.dart';
import '../ui/widgets/image_container.dart';
String randomImage =  randomImageChooser("Cezanne");
class Cezanne extends StatefulWidget {
  const Cezanne({super.key, required this.title, this.plannerId, this.date});
  final String title;
  final int? plannerId;
  final String? date;
  @override
  State<Cezanne> createState() => _CezanneState();
}

class _CezanneState extends State<Cezanne> {
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
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          navbarProvider.showNavbar();
        }
      },
      child: Scaffold(
        appBar: ShimmerAppBar(isLoading: isLoading, colorList: colorList),
        backgroundColor: colorList.last,
        resizeToAvoidBottomInset: true,
        body: _buildBody(deviceWidth, deviceHeight),
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
        ) else Padding(
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