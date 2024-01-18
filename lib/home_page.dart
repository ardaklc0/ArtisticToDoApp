import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro2/CreationPage/planner_service.dart';
import 'package:pomodoro2/Task/task_service.dart';
import 'package:pomodoro2/VanGoghCreation/van_gogh.dart';
import 'package:pomodoro2/VanGoghCreation/van_gogh_variables.dart';
import 'package:pomodoro2/main.dart';

import 'CreationPage/planner_entity.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Padding>> addCreatedPlanners;

  @override
  void initState(){
    super.initState();
    addCreatedPlanners = fetchPlanners();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(deviceWidth * 0.05)),
      ),
    );

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
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () {
                          Navigator.pushNamed(context, '/gustav_klimt');
                        },
                        child: const Text('Gustav Klimt'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () {
                          Navigator.pushNamed(context, '/osman_hamdi');
                        },
                        child: const Text('Osman Hamdi Bey'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () {
                          Navigator.pushNamed(context, '/monet');
                        },
                        child: const Text('Monet'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () {
                          Navigator.pushNamed(context, '/picasso');
                        },
                        child: const Text('Picasso'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () {
                          Navigator.pushNamed(context, '/salvador_dali');
                        },
                        child: const Text('Salvador Dali'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () async {
                          createVanGogh();
                          Navigator.pushNamed(context, '/van_gogh');
                        },
                        child: const Text('Van Gogh'),
                      ),
                    ),

                  ],
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
                  width: deviceWidth * 0.5,
                  height: deviceHeight * 0.2,
                  child: FutureBuilder<List<Padding>>(
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

  void goToVanGogh(int plannerId) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return VanGogh(title: "Van Gogh", plannerId: plannerId);
    }));
  }

  Future<void> createVanGogh() async {
    DateTime dateTime = DateTime.now();
    String dayFormat = DateFormat('yMd').format(dateTime).toString();
    Planner planner = Planner(
        creationDate: dayFormat,
        plannerArtist: "VanGogh"
    );
    await insertPlanner(planner);
  }

  Future<List<Padding>> fetchPlanners() async {
    var planners = await getPlanners();
    List<Padding> plannerContainers = [];
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.black,
    );

    for (var element in planners) {
      plannerContainers.add(
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton(
            style: raisedButtonStyle,
            onPressed: () async {
              goToVanGogh(element.id!);
            },
            child: Text('Van Gogh ${element.id} ${element.creationDate} ${element.plannerArtist}'),
          ),
        ),
      );
    }
    return plannerContainers;
  }


}


