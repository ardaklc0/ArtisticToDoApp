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
  late Future<SingleChildScrollView> taskFuture;

  @override
  void initState(){
    super.initState();
    taskFuture = createTask(
      GustavKlimtVariables.dateColor,
      GustavKlimtVariables.taskColor,
      GustavKlimtVariables.textColor,
    );
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
            ImageContainer(
              imageUrl: 'assets/images/Gustav Klimt/1.jpg',
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