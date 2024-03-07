import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pomodoro2/provider/audio_provider.dart';
import 'package:pomodoro2/provider/auto_start_provider.dart';
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
import 'package:pomodoro2/ui/widgets/task_container_test.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
int chosenBackground = Random().nextInt(4) + 2;
int chosenStagger = Random().nextInt(5) + 1;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sliderProvider = SliderProvider();
  final autoStartProvider = AutoStartProvider();
  final themeProvider = ThemeProvider();
  final notificationProvider = NotificationProvider();
  final plannerProvider = PlannerProvider();
  final taskProvider = TaskProvider();
  final navbarProvider = NavbarProvider();
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
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(), //HomePageTest(),
          '/gustav_klimt': (context) => GustavKlimt(title: 'Gustav Klimt Home Page'),
          '/osman_hamdi': (context) => OsmanHamdi(title: 'Osman Hamdi Page'),
          '/monet': (context) => Monet(title: 'Monet Page'),
          '/picasso': (context) => Picasso(title: 'Picasso Home Page'),
          '/salvador_dali': (context) => SalvadorDali(title: 'Salvador Dali Page'),
          '/van_gogh': (context) => VanGogh(title: 'Van Gogh Page'),
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
  for (int i = 0; i <= 7; i++) {
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
      child: Column(
        children: [
          ...newContainer
        ],
      )
  );
}


