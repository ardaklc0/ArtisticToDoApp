import 'package:flutter/material.dart';
import 'package:pomodoro2/Task/task_service.dart';
import '../image_container.dart';
import '../main.dart';
import 'osman_hamdi_variables.dart';

class OsmanHamdi extends StatefulWidget {
  const OsmanHamdi({super.key, required this.title});
  final String title;

  @override
  State<OsmanHamdi> createState() => _OsmanHamdiState();
}

class _OsmanHamdiState extends State<OsmanHamdi> {

  @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: OsmanHamdiVariables.taskColor,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const ImageContainer(
              imageUrl: 'assets/images/Osman Hamdi Bey/1.jpg',
              imageAlignment: Alignment(0, -1),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: OsmanHamdiVariables.dateColor,
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


