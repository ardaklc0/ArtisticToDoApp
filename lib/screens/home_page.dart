import 'package:flutter/material.dart';
import 'package:pomodoro2/screens/created_planners.dart';
import 'package:pomodoro2/ui/helper/common_functions.dart';
import 'package:pomodoro2/ui/styles/common_styles.dart';
import '../ui/helper/common_variables.dart';
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
      body: _body(deviceHeight, createArtistButton, goToCreatedPlanners)
    );
  }
  List<Container> createArtistButton(double deviceHeight){
    List<Container> artistButtons = [];
    artists.forEach((key, value) {
      artistButtons.add(
        Container(
          width: double.infinity,
          height: deviceHeight * 0.08,
          padding: const EdgeInsets.all(2),
          child: ElevatedButton(
            style: mainUiRaisedButtonStyle,
            onPressed: () async {
              await createPlannerWrtArtist(key);
              setState(() {
                addCreatedPlanners = fetchPlanners(context, deviceHeight);
              });
              goToCreatedPlanners();
            },
            child: Text(
              value,
              style: TextStyle(
                fontSize: deviceHeight * 0.02,
              ),
            ),
          ),
        ),
      );
    });
    return artistButtons;
  }
  void goToCreatedPlanners() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const CreatedPlanners();
    }));
  }
}

Widget _body(double deviceHeight, Function createArtistButton, Function goToCreatedPlanners) => Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SingleChildScrollView(
        child: Column(
            children: createArtistButton(deviceHeight)
        ),
      ),
      Container(
        width: double.infinity,
        height: deviceHeight * 0.07,
        padding: const EdgeInsets.all(2),
        child: ElevatedButton(
          style: mainUiRaisedButtonStyle,
          onPressed: () async {
            goToCreatedPlanners();
          },
          child: Text(
            "Go To Created Planners",
            style: TextStyle(
                fontSize: deviceHeight * 0.02
            ),
          ),
        ),
      ),
    ],
  ),
);

