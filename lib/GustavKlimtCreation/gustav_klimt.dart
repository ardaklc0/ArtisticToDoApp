import 'package:flutter/material.dart';
import '../main.dart';
import 'gustav_klimt_variables.dart';
import '../image_container.dart';

class GustavKlimt extends StatefulWidget {
  const GustavKlimt({super.key, required this.title});
  final String title;

  @override
  State<GustavKlimt> createState() => _GustavKlimtState();
}

class _GustavKlimtState extends State<GustavKlimt> {

  @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: GustavKlimtVariables.taskColor,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const ImageContainer(
              imageUrl: 'assets/images/Gustav Klimt/1.jpg',
              imageAlignment: Alignment(0, -1),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: GustavKlimtVariables.dateColor,
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