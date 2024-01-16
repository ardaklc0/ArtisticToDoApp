import 'package:flutter/material.dart';
import 'package:pomodoro2/GustavKlimtCreation/gustav_klimt.dart';
import 'package:pomodoro2/MonetCreation/monet.dart';
import 'package:pomodoro2/home_page.dart';
import 'package:pomodoro2/task_container.dart';
import 'OsmanHamdiCreation/osman_hamdi.dart';
import 'package:intl/intl.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/gustav_klimt': (context) => const GustavKlimt(title: 'Gustav Klimt Home Page'),
        '/osman_hamdi': (context) => const OsmanHamdi(title: 'Osman Hamdi Page'),
        '/monet': (context) => const Monet(title: 'Monet Page')
      },
    );
  }
}

SingleChildScrollView createTask(Color dateColor, Color? taskColor, Color? textColor) {
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
      dateColor: dateColor,
      taskColor: taskColor,
      textColor: textColor,
    ));
    dateTime = dateTime.add(const Duration(days: 1));
  }
  return SingleChildScrollView(
      child: Column(
        children: [
          ...newContainer
        ],
      )
  );
}