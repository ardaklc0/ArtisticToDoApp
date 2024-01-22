import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro2/CreationPage/planner_service.dart';
import 'package:pomodoro2/GustavKlimtCreation/gustav_klimt.dart';
import 'package:pomodoro2/OsmanHamdiCreation/osman_hamdi.dart';
import 'package:pomodoro2/PlannerPage/created_planners.dart';
import 'package:pomodoro2/PlannerPage/planner_common_functions.dart';
import 'package:pomodoro2/SalvadorDaliCreation/salvador_dali.dart';
import 'package:pomodoro2/VanGoghCreation/van_gogh.dart';
import '../CreationPage/planner_entity.dart';
import '../MonetCreation/monet.dart';
import '../PicassoCreation/picasso.dart';
final Map<String, String> artists =
{
  "GustavKlimt":"Gustav Klimt",
  "OsmanHamdi":"Osman Hamdi Bey",
  "Monet":"Monet",
  "Picasso":"Picasso",
  "SalvadorDali":"Salvador Dali",
  "VanGogh":"Van Gogh"
};
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
      backgroundColor: const Color.fromRGBO(231, 90, 124, 1),
      body: Center(
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
                style: raisedButtonStyle,
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
      ),
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
            style: raisedButtonStyle,
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

