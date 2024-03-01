import 'dart:math';
import 'package:flutter/material.dart';
import '../main.dart';
import '../ui/helper/common_functions.dart';
import '../ui/widgets/common_widgets.dart';
import '../ui/widgets/image_container.dart';
class Monet extends StatefulWidget {
  const Monet({super.key, required this.title, this.plannerId, this.date, required this.randomImage});
  final String title;
  final String randomImage;
  final int? plannerId;
  final String? date;
  @override
  State<Monet> createState() => _MonetState();
}
class _MonetState extends State<Monet> {
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
      backgroundColor: colorList.last,
      resizeToAvoidBottomInset: true,
      body: _body(deviceWidth, taskFuture, widget.randomImage, context),
      floatingActionButton: _floatingActionButton(colorList.last, context),
    );
  }

  Widget _body(double deviceWidth, Future<SingleChildScrollView> taskFuture, String randomImage, BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ImageContainer(
          imageUrl: randomImage,
          imageAlignment: Alignment.center,
        ),
        Center(
          child: isLoading // Show CircularProgressIndicator if still loading
              ? const CircularProgressIndicator()
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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

  Widget _floatingActionButton(Color floatingActionButtonColor, BuildContext context) {
    return FloatingActionButton(
      backgroundColor: floatingActionButtonColor,
      child: homeIconForFloatingActionButton,
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}