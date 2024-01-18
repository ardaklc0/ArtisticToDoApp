import 'package:flutter/material.dart';
import 'package:pomodoro2/GustavKlimtCreation/gustav_klimt.dart';
import 'package:pomodoro2/MonetCreation/monet.dart';
import 'package:pomodoro2/home_page.dart';
import 'package:pomodoro2/Task/task_container.dart';
import 'package:pomodoro2/Task/task_service.dart';
import 'OsmanHamdiCreation/osman_hamdi.dart';
import 'package:intl/intl.dart';
import 'PicassoCreation/picasso.dart';
import 'SalvadorDaliCreation/salvador_dali.dart';
import 'Task/task_entity.dart';
import 'VanGoghCreation/van_gogh.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
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
        '/monet': (context) => const Monet(title: 'Monet Page'),
        '/picasso': (context) => const Picasso(title: 'Picasso Home Page'),
        '/salvador_dali': (context) => const SalvadorDali(title: 'Salvador Dali Page'),
        '/van_gogh': (context) => const VanGogh(title: 'Van Gogh Page'),
      },
    );
  }
}

Future<SingleChildScrollView> createPlanner(String dateTime, int plannerId, Color dateColor, Color? taskColor, Color? textColor) async {
  List<TaskContainer> newContainer = [];
  DateFormat inputFormat = DateFormat("M/d/yyyy");
  DateTime parsedDateTime = inputFormat.parse(dateTime);
  DateFormat dateFormat = DateFormat('yMd');
  DateFormat dayFormat = DateFormat('EEEE');
  String date = "";
  String day = "";
  var tasks = await getTasks(plannerId);
  for (int i = 0; i < 7; i++) {
    date = dateFormat.format(parsedDateTime);
    day = dayFormat.format(parsedDateTime);
    newContainer.add(TaskContainer(
      dayText: day,
      dateText: date,
      dateColor: dateColor,
      taskColor: taskColor,
      textColor: textColor,
      plannerId: plannerId,
      tasks: tasks,
    ));
    parsedDateTime = parsedDateTime.add(const Duration(days: 1));
  }
  return SingleChildScrollView(
      child: Column(
        children: [
          ...newContainer
        ],
      )
  );
}


