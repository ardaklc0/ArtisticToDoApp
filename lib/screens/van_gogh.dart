import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../main.dart';
import '../provider/navbar_provider.dart';
import '../ui/helper/common_functions.dart';
import '../ui/widgets/image_container.dart';
//int chosenBackground = Random().nextInt(4) + 2;
String randomImage =  randomImageChooser("VanGogh", 10);
class VanGogh extends StatefulWidget {
  const VanGogh({Key? key, required this.title, this.plannerId, this.date}) : super(key: key);
  final String title;
  final int? plannerId;
  final String? date;
  @override
  State<VanGogh> createState() => _VanGoghState();
}
class _VanGoghState extends State<VanGogh> {
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
      await Future.delayed(const Duration(milliseconds: 1700));
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
      appBar: AppBar(
        flexibleSpace: isLoading
            ? Shimmer.fromColors(
              baseColor: Colors.grey.shade200.withOpacity(0.5),
              highlightColor: Colors.grey.shade200.withOpacity(0.5),
              child: Container(
                width: double.infinity,
                height: kToolbarHeight + MediaQuery.of(context).padding.top,
                color: Colors.grey.shade200.withOpacity(0.5),
              ),
            )
            : AppBar(
                backgroundColor: colorList.last,
                elevation: 2,
                toolbarOpacity: 0.7,
                bottomOpacity: 0.5,
              ),
            ),
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

