import 'package:flutter/material.dart';
import 'package:pomodoro2/screens/created_planners.dart';
import 'package:pomodoro2/screens/pomodoro.dart';
import 'package:pomodoro2/screens/pomodoro_migration.dart';
import 'package:pomodoro2/screens/test.dart';
import 'package:pomodoro2/ui/helper/common_functions.dart';
import 'package:pomodoro2/ui/styles/common_styles.dart';
import '../ui/helper/common_variables.dart';
import '../ui/widgets/common_widgets.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  void initState(){
    super.initState();
  }
  late Future<List<Container>> addCreatedPlanners;
  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: homePageColor,
      body: _body(deviceHeight, createArtistButton, goToPomodoro, goToPomodoroMig, goToTestPage),
    );
  }
  List<Padding> createArtistButton(double deviceHeight) {
    List<Padding> artistButtons = [];
    artists.forEach((key, value) {
      artistButtons.add(
        Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            width: double.infinity,
            height: deviceHeight * 0.12,
            padding: EdgeInsets.zero,
            child: ElevatedButton(
              style: mainUiRaisedButtonStyle,
              onPressed: () async {
                await createPlannerWrtArtist(key);
                setState(() {
                  addCreatedPlanners = fetchPlanners(context, deviceHeight);
                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/Thumbnail/4.jpg',
                    fit: BoxFit.fill,
                    width: deviceHeight * 0.1,
                    height: deviceHeight * 0.1,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: deviceHeight * 0.02,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
    return artistButtons;
  }
  void goToTestPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return TestPage();
    }));
  }
  void goToPomodoroMig() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const CountDownTimerPage();
    }));
  }
  void goToPomodoro() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const Pomodoro();
    }));
  }
}

Widget _body(double deviceHeight, Function createArtistButton, Function goToPomodoro, Function goToPomodoroMig, Function goToTestPage) => Center(
  child: SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
            children: createArtistButton(deviceHeight)
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            width: double.infinity,
            height: deviceHeight * 0.07,
            padding: const EdgeInsets.all(2),
            child: ElevatedButton(
              style: mainUiRaisedButtonStyle,
              onPressed: () async {
              },
              child: Text(
                "Go To Created Planners",
                style: TextStyle(
                    fontSize: deviceHeight * 0.02
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            width: double.infinity,
            height: deviceHeight * 0.07,
            padding: const EdgeInsets.all(1),
            child: ElevatedButton(
              style: mainUiRaisedButtonStyle,
              onPressed: () async {
                goToPomodoroMig();
              },
              child: Text(
                "Go To Pomodoro Migration",
                style: TextStyle(
                    fontSize: deviceHeight * 0.02
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            width: double.infinity,
            height: deviceHeight * 0.07,
            padding: const EdgeInsets.all(1),
            child: ElevatedButton(
              style: mainUiRaisedButtonStyle,
              onPressed: () async {
                goToTestPage();
              },
              child: Text(
                "Go To Test",
                style: TextStyle(
                    fontSize: deviceHeight * 0.02
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget _floatingActionButton(Color floatingActionButtonColor, BuildContext context) => FloatingActionButton(
  backgroundColor: floatingActionButtonColor,
  child: homeIconForFloatingActionButton,
  onPressed: () {
    Navigator.pop(context);
  },
);