import 'package:flutter/material.dart';
import 'package:pomodoro2/task_service.dart';
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
  late Future<SingleChildScrollView> taskFuture;

  @override
  void initState(){
    super.initState();
    taskFuture = createTask(
      OsmanHamdiVariables.dateColor,
      OsmanHamdiVariables.taskColor,
      OsmanHamdiVariables.textColor,
    );
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
            ImageContainer(
              imageUrl: 'assets/images/Osman Hamdi Bey/1.jpg',
              imageAlignment: const Alignment(0, -1),
              scaleOfImage: deviceWidth * 0.003,
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


