import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro2/CreationPage/planner_service.dart';
import 'package:pomodoro2/GustavKlimtCreation/gustav_klimt.dart';
import 'package:pomodoro2/OsmanHamdiCreation/osman_hamdi.dart';
import 'package:pomodoro2/SalvadorDaliCreation/salvador_dali.dart';
import 'package:pomodoro2/VanGoghCreation/van_gogh.dart';
import 'CreationPage/planner_entity.dart';
import 'MonetCreation/monet.dart';
import 'PicassoCreation/picasso.dart';
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
              Text(
                "Created Planners",
                style: TextStyle(
                  fontSize: deviceWidth * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  width: deviceWidth * 0.7,
                  height: deviceHeight * 0.3,
                  child: FutureBuilder<List<ElevatedButton>>(
                    future: fetchPlanners(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return snapshot.data![index];
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void goToArtist(String artist, int plannerId, String date) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      switch (artist) {
        case "VanGogh":
          return VanGogh(title: "Van Gogh", plannerId: plannerId, date: date);
        case "SalvadorDali":
          return SalvadorDali(title: "Salvador Dali", plannerId: plannerId, date: date);
        case "Picasso":
          return Picasso(title: "Picasso", plannerId: plannerId, date: date);
        case "Monet":
          return Monet(title: "Monet", plannerId: plannerId, date: date);
        case "OsmanHamdi":
          return OsmanHamdi(title: "OsmanHamdi", plannerId: plannerId, date: date);
        case "GustavKlimt":
          return GustavKlimt(title: "GustavKlimt", plannerId: plannerId, date: date);
        default:
          throw ArgumentError("Unsupported artist: $artist");
      }
    }));
  }

  Future<int> createPlannerWrtArtist(String artistName) async {
    DateTime dateTime = DateTime.now();
    String dayFormat = DateFormat('yMd').format(dateTime).toString();
    Planner planner = Planner(
        creationDate: dayFormat,
        plannerArtist: artistName
    );
    return await insertPlanner(planner);
  }

  Future<List<ElevatedButton>> fetchPlanners() async {
    List<ElevatedButton> plannerContainers = [];
    try {
      var planners = await getPlanners();
      if (planners.isEmpty) {
        var plannerId = await createPlannerWrtArtist("VanGogh");
        planners = await getPlanners();
        var existingPlanner = await getPlanner(plannerId);
        goToArtist("VanGogh", plannerId, existingPlanner!.creationDate);
      }
      for (var element in planners) {
        plannerContainers.add(
          ElevatedButton(
            style: raisedButtonStyle,
            onPressed: () async {
              goToArtist(element.plannerArtist, element.id!, element.creationDate);
            },
            child: Text('${element.id}.) at ${element.creationDate} with ${element.plannerArtist}'),
          ),
        );
      }
    } catch (e) {
      print('Error fetching planners: $e');
    }

    return plannerContainers;
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
              addCreatedPlanners = fetchPlanners();
            });
          },
          child: Text(value),
        ),
      );
    });
    return artistButtons;
  }
}

