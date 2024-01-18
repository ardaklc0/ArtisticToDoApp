import 'package:flutter/material.dart';
import 'package:pomodoro2/MonetCreation/monet_variables.dart';
import 'package:pomodoro2/Task/task_service.dart';
import 'package:pomodoro2/VanGoghCreation/van_gogh_variables.dart';
import '../main.dart';
import '../image_container.dart';

class VanGogh extends StatefulWidget {
  const VanGogh({super.key, required this.title, this.plannerId});
  final String title;
  final int? plannerId;

  @override
  State<VanGogh> createState() => _VanGoghState();
}

class _VanGoghState extends State<VanGogh> {
  late Future<SingleChildScrollView> taskFuture;

  @override
  void initState(){
    super.initState();
    taskFuture = createPlanner(
      "1/18/2024",
      widget.plannerId!,
      VanGoghVariables.dateColor,
      VanGoghVariables.taskColor,
      VanGoghVariables.textColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: VanGoghVariables.taskColor,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const ImageContainer(
              imageUrl: 'assets/images/Van Gogh/6.jpg',
              imageAlignment: Alignment(0, -1),
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
        backgroundColor: VanGoghVariables.dateColor,
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
