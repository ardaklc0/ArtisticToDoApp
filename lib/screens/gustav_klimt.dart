import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pomodoro2/ui/helper/common_functions.dart';
import 'package:pomodoro2/ui/widgets/common_widgets.dart';
import '../main.dart';
import '../ui/widgets/image_container.dart';
class GustavKlimt extends StatefulWidget {
  const GustavKlimt({super.key, required this.title, this.plannerId, this.date, required this.randomImage});
  final String title;
  final String randomImage;
  final int? plannerId;
  final String? date;
  @override
  State<GustavKlimt> createState() => _GustavKlimtState();
}
class _GustavKlimtState extends State<GustavKlimt> {
  late Future<SingleChildScrollView> taskFuture;
  late List<Color> colorList;
  @override
  void initState() {
    super.initState();
    Random random = Random();
    int chosenBackground = random.nextInt(4) + 2;
    colorList = [Colors.transparent, Colors.transparent];
    taskFuture = createPlanner(
      widget.date!,
      widget.plannerId!,
      Colors.transparent,
      Colors.transparent,
      Colors.black,
    );
    sortedColors(widget.randomImage).then((List<Color> colors) {
      setState(() {
        colorList = colors;
        taskFuture = createPlanner(
          widget.date!,
          widget.plannerId!,
          colorList.last,
          colorList.elementAt(chosenBackground),
          Colors.black,
        );
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
      floatingActionButton: _floatingActionButton(colorList.last, context)
    );
  }
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
Widget _floatingActionButton(Color floatingActionButtonColor, BuildContext context) => FloatingActionButton(
  backgroundColor: floatingActionButtonColor,
  child: homeIconForFloatingActionButton,
  onPressed: () {
    Navigator.pop(context);
  },
);