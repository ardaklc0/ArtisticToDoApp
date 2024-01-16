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
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const ImageContainer(
              imageUrl: 'assets/images/Gustav Klimt/1.jpg',
              imageAlignment: Alignment(0, -1),
              scaleOfImage: 1.2,
            ),
            Flexible(
              child: createTask(
                GustavKlimtVariables.dateColor,
                GustavKlimtVariables.taskColor,
                GustavKlimtVariables.textColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}