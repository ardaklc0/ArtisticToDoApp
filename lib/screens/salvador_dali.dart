import 'dart:math';

import 'package:flutter/material.dart';
import '../main.dart';
import '../ui/helper/common_functions.dart';
import '../ui/widgets/common_widgets.dart';
import '../ui/widgets/image_container.dart';
class SalvadorDali extends StatefulWidget{
  const SalvadorDali({super.key, required this.title, this.plannerId, this.date, required this.randomImage});
  final String title;
  final String randomImage;
  final int? plannerId;
  final String? date;
  @override
  State<SalvadorDali> createState() => _SalvadorDaliState();
}
class _SalvadorDaliState extends State<SalvadorDali> {
  late Future<SingleChildScrollView> taskFuture;
  late List<Color> colorList;
  bool isLoading = true; // Added loading indicator flag
  @override
  void initState() {
    super.initState();
    colorList = [Colors.transparent, Colors.transparent];
    taskFuture = createPlanner(
      widget.date!,
      widget.plannerId!,
      Colors.transparent,
      Colors.transparent,
      Colors.black,
    );

    // Show loading indicator initially
    setState(() {
      isLoading = true;
    });

    sortedColors(widget.randomImage).then((List<Color> colors) {
      setState(() {
        colorList = colors;
        int chosenBackground = Random().nextInt(4) + 2;
        taskFuture = createPlanner(
          widget.date!,
          widget.plannerId!,
          colorList.last,
          colorList.elementAt(chosenBackground),
          Colors.black,
        );
        isLoading = false; // Set loading indicator to false when colors are determined
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:isLoading ? AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ) : AppBar(
        backgroundColor: colorList.last,
        elevation: 0,
        shadowColor: Colors.black,
        toolbarOpacity: 0.7,
        bottomOpacity: 0.5,
      ),
      backgroundColor: colorList.last,
      resizeToAvoidBottomInset: true,
      body: _body(deviceWidth, taskFuture, widget.randomImage, context),
    );
  }

  Widget _body(double deviceWidth, Future<SingleChildScrollView> taskFuture, String randomImage, BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      // Background Image
      ImageContainer(
        imageUrl: randomImage, // Replace with your background image asset path or URL
        imageAlignment: Alignment.center, // Adjust the fit as needed
      ),
      // Content
      Center(
        child: isLoading // Show CircularProgressIndicator if still loading
            ? const CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: FutureBuilder<SingleChildScrollView>(
                future: taskFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
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