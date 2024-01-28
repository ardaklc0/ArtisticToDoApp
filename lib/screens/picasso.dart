import 'dart:math';

import 'package:flutter/material.dart';
import '../main.dart';
import '../ui/helper/common_functions.dart';
import '../ui/helper/picasso_variables.dart';
import '../ui/widgets/common_widgets.dart';
import '../ui/widgets/image_container.dart';
class Picasso extends StatefulWidget {
  const Picasso({super.key, required this.title, this.plannerId, this.date, required this.randomImage});
  final String title;
  final String randomImage;
  final int? plannerId;
  final String? date;

  @override
  State<Picasso> createState() => _PicassoState();
}
class _PicassoState extends State<Picasso> {
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
Widget _body(double deviceWidth, Future<SingleChildScrollView> taskFuture, String randomImage, BuildContext context) =>Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      ImageContainer(
        imageUrl: randomImage,
        imageAlignment: const Alignment(0, -1),
      ),
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
          )
      )
    ],
  ),
);
Widget _floatingActionButton(Color floatingActionButtonColor, BuildContext context) => FloatingActionButton(
  backgroundColor: floatingActionButtonColor,
  child: homeIconForFloatingActionButton,
  onPressed: () {
    Navigator.pop(context);
  },
);