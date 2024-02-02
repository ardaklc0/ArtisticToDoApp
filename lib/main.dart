import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pomodoro2/provider/audio_provider.dart';
import 'package:pomodoro2/provider/auto_start_provider.dart';
import 'package:pomodoro2/provider/notification_provider.dart';
import 'package:pomodoro2/provider/planner_provider.dart';
import 'package:pomodoro2/provider/slider_provider.dart';
import 'package:pomodoro2/provider/task_provider.dart';
import 'package:pomodoro2/provider/theme_provider.dart';
import 'package:pomodoro2/provider/time_provider.dart';
import 'package:pomodoro2/screens/gustav_klimt.dart';
import 'package:pomodoro2/screens/home_page.dart';
import 'package:pomodoro2/screens/monet.dart';
import 'package:pomodoro2/screens/osman_hamdi.dart';
import 'package:pomodoro2/screens/picasso.dart';
import 'package:pomodoro2/screens/pomodoro.dart';
import 'package:pomodoro2/screens/salvador_dali.dart';
import 'package:pomodoro2/screens/van_gogh.dart';
import 'package:pomodoro2/ui/helper/common_functions.dart';
import 'package:pomodoro2/ui/widgets/task_container.dart';
import 'package:pomodoro2/services/task_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'screens/created_planners.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sliderProvider = SliderProvider();
  final autoStartProvider = AutoStartProvider();
  final themeProvider = ThemeProvider();
  final notificationProvider = NotificationProvider();
  final plannerProvider = PlannerProvider();
  final taskProvider = TaskProvider();
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
        ChangeNotifierProvider.value(value: taskProvider)
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
          '/': (context) => const HomePage(),
          '/created_planners': (context) => const CreatedPlanners(),
          '/gustav_klimt': (context) => GustavKlimt(title: 'Gustav Klimt Home Page', randomImage: randomImageChooser("Gustav Klimt", 20)),
          '/osman_hamdi': (context) => OsmanHamdi(title: 'Osman Hamdi Page', randomImage: randomImageChooser("Osman Hamdi Bey", 11)),
          '/monet': (context) => Monet(title: 'Monet Page', randomImage: randomImageChooser("Monet", 22)),
          '/picasso': (context) => Picasso(title: 'Picasso Home Page', randomImage: randomImageChooser("Picasso", 12)),
          '/salvador_dali': (context) => SalvadorDali(title: 'Salvador Dali Page', randomImage: randomImageChooser("Dali", 9)),
          '/van_gogh': (context) => VanGogh(title: 'Van Gogh Page', randomImage: randomImageChooser("Van Gogh", 17)),
          '/pomodoro': (context) => const Pomodoro()
        },
      ),
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


