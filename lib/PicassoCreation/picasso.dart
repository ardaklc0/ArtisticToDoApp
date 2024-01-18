import 'package:flutter/material.dart';
import 'package:pomodoro2/MonetCreation/monet_variables.dart';
import 'package:pomodoro2/PicassoCreation/picasso_variables.dart';
import '../main.dart';
import '../image_container.dart';

class Picasso extends StatefulWidget {
  const Picasso({super.key, required this.title});
  final String title;

  @override
  State<Picasso> createState() => _PicassoState();
}

class _PicassoState extends State<Picasso> {

  @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: PicassoVariables.taskColor,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const ImageContainer(
              imageUrl: 'assets/images/Picasso/2.jpg',
              imageAlignment: Alignment(0, -1),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PicassoVariables.dateColor,
        child: const Icon(
            Icons.home_filled
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
