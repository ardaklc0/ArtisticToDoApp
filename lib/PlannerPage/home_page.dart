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
final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: Colors.white,
  backgroundColor: Colors.black,
);
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  late Future<List<ElevatedButton>> addCreatedPlanners;
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Choose an artist to start your journey!",
              style: TextStyle(
                fontSize: deviceWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: createArtistButton()
              ),
            ),
            ElevatedButton(
              style: raisedButtonStyle,
              onPressed: () async {
                goToCreatedPlanners();
              },
              child: const Text("Go To Created Planners"),
            ),
          ],
        ),
      ),
    );
  }
  List<ElevatedButton> createArtistButton(){
    List<ElevatedButton> artistButtons = [];
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.black,
    );
    artists.forEach((key, value) {
      artistButtons.add(
        ElevatedButton(
          style: raisedButtonStyle,
          onPressed: () async {
            await createPlannerWrtArtist(key);
            setState(() {
              addCreatedPlanners = fetchPlanners(context);
            });
            goToCreatedPlanners();
          },
          child: Text(value),
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

