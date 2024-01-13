import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomodoro2/task_container.dart';
import 'gustav_klimt_variables.dart';
import 'image_container.dart';
import 'package:intl/intl.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const ImageContainer(
              imageUrl: 'assets/images/Gustav Klimt/1.jpg',
              imageAlignment: Alignment(0, -1),
              scaleOfImage: 1.2,
            ),
            Expanded(
              child:SingleChildScrollView(
                child: createTask()
              ),
            )
          ],
        ),
      ),
    );
  }
}

Column createTask() {
  List<TaskContainer> newContainer = [];
  DateTime dateTime = DateTime.now();
  DateFormat dateFormat = DateFormat('yMd');
  DateFormat dayFormat = DateFormat('EEEE');
  String date = "";
  String day = "";
  for (int i = 0; i < 7; i++) {
    date = dateFormat.format(dateTime);
    day = dayFormat.format(dateTime);
    newContainer.add(TaskContainer(
      dayText: day,
      dateText: date,
      dateColor: GustavKlimtVariables.dateColor,
      taskColor: GustavKlimtVariables.taskColor,
      textColor: GustavKlimtVariables.textColor,
    ));
    dateTime = dateTime.add(const Duration(days: 1));
  }
  return Column(
    children: [
      ...newContainer
    ],
  );
}