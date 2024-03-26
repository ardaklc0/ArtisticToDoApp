import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pomodoro2/provider/audio_provider.dart';
import 'package:pomodoro2/provider/auto_start_provider.dart';
import 'package:pomodoro2/provider/keyboard_provider.dart';
import 'package:pomodoro2/provider/navbar_provider.dart';
import 'package:pomodoro2/provider/notification_provider.dart';
import 'package:pomodoro2/provider/planner_provider.dart';
import 'package:pomodoro2/provider/slider_provider.dart';
import 'package:pomodoro2/provider/task_provider.dart';
import 'package:pomodoro2/provider/theme_provider.dart';
import 'package:pomodoro2/provider/time_provider.dart';
import 'package:pomodoro2/screens/gustav_klimt.dart';
import 'package:pomodoro2/screens/home_page_test.dart';
import 'package:pomodoro2/screens/monet.dart';
import 'package:pomodoro2/screens/osman_hamdi.dart';
import 'package:pomodoro2/screens/picasso.dart';
import 'package:pomodoro2/screens/pomodoro.dart';
import 'package:pomodoro2/screens/pomodoro_migration.dart';
import 'package:pomodoro2/screens/salvador_dali.dart';
import 'package:pomodoro2/screens/splash.dart';
import 'package:pomodoro2/screens/van_gogh.dart';
import 'package:pomodoro2/services/task_service.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro2/ui/widgets/task_container.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
int chosenBackground = Random().nextInt(10) + 1;
int chosenArtist = Random().nextInt(8);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sliderProvider = SliderProvider();
  final autoStartProvider = AutoStartProvider();
  final themeProvider = ThemeProvider();
  final notificationProvider = NotificationProvider();
  final plannerProvider = PlannerProvider();
  final taskProvider = TaskProvider();
  final navbarProvider = NavbarProvider();
  final keyboardProvider = KeyboardProvider();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeProvider),
        ChangeNotifierProvider(create: (context) => TimerProvider()),
        ChangeNotifierProvider.value(value: sliderProvider),
        ChangeNotifierProvider.value(value: notificationProvider),
        ChangeNotifierProvider(create: (context) => SoundSelectionProvider()),
        ChangeNotifierProvider.value(value: autoStartProvider),
        ChangeNotifierProvider.value(value: plannerProvider),
        ChangeNotifierProvider.value(value: taskProvider),
        ChangeNotifierProvider.value(value: navbarProvider),
        ChangeNotifierProvider.value(value: keyboardProvider),
      ],
      child: const MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return OverlaySupport.global(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Planart',
        theme: ThemeData(
          useMaterial3: true,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.black,
            selectionHandleColor: Colors.black,
            selectionColor: Colors.black38,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(), //HomePageTest(),
          '/gustav_klimt': (context) => const GustavKlimt(title: 'Gustav Klimt Home Page'),
          '/osman_hamdi': (context) => const OsmanHamdi(title: 'Osman Hamdi Page'),
          '/monet': (context) => const Monet(title: 'Monet Page'),
          '/picasso': (context) => const Picasso(title: 'Picasso Home Page'),
          '/salvador_dali': (context) => const SalvadorDali(title: 'Salvador Dali Page'),
          '/van_gogh': (context) => const VanGogh(title: 'Van Gogh Page'),
          '/pomodoro': (context) => const Pomodoro(),
          '/pomodoro_migration': (context) => const CountDownTimerPage(),
          '/home_page_test': (context) => const HomePageTest()
        },
      ),
    );
  }
}

Future<SingleChildScrollView> createPlanner(String dateTime, int plannerId, Color dateColor, Color? taskColor, Color? textColor) async {
  List<TaskContainerTest> newContainer = [];
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
    newContainer.add(
      // Normally it is "TaskContainer" but for the sake of testing, it is "TaskContainerTest"
      TaskContainerTest(
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
      reverse: true,
      child: Column(
        children: [
          ...newContainer
        ],
      )
  );
}

/*
Leonardo da Vinci (1452-1519)
Michelangelo Buonarroti (1475-1564)
Raphael (1483-1520)
Sandro Botticelli (1445-1510)
Jan van Eyck (c. 1390-1441)
Caravaggio (1571-1610)
Rembrandt van Rijn (1606-1669)
Peter Paul Rubens (1577-1640)
Johannes Vermeer (1632-1675)
Diego Velázquez (1599-1660)
Pieter Bruegel the Elder (c. 1525-1569)
Titian (c. 1488-1576)
Vincent van Gogh (1853-1890)
Paul Cézanne (1839-1906)
Edgar Degas (1834-1917)
Édouard Manet (1832-1883)
Claude Monet (1840-1926)
Pierre-Auguste Renoir (1841-1919)
Mary Cassatt (1844-1926)
Gustav Klimt (1862-1918)
* */

