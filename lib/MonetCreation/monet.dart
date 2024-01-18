import 'package:flutter/material.dart';
import 'package:pomodoro2/MonetCreation/monet_variables.dart';
import '../main.dart';
import '../image_container.dart';

class Monet extends StatefulWidget {
  const Monet({super.key, required this.title});
  final String title;

  @override
  State<Monet> createState() => _MonetState();
}

class _MonetState extends State<Monet> {

  @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MonetVariables.taskColor,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const ImageContainer(
              imageUrl: 'assets/images/Monet/1.jpg',
              imageAlignment: Alignment(0, -1),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MonetVariables.dateColor,
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