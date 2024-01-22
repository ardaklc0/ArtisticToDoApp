import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../CreationPage/planner_entity.dart';
import '../CreationPage/planner_service.dart';
import '../GustavKlimtCreation/gustav_klimt.dart';
import '../MonetCreation/monet.dart';
import '../OsmanHamdiCreation/osman_hamdi.dart';
import '../PicassoCreation/picasso.dart';
import '../SalvadorDaliCreation/salvador_dali.dart';
import '../VanGoghCreation/van_gogh.dart';
final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: const Color.fromRGBO(44, 54, 63, 1),
  backgroundColor: const Color.fromRGBO(242, 245, 234, 1),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(0.0), // Adjust the radius as needed
  ),
);
void goToArtist(BuildContext context, String artist, int plannerId, String date) {
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
Future<List<Container>> fetchPlanners(BuildContext context, double deviceHeight) async {
  List<Container> plannerContainers = [];
  try {
    var planners = await getPlanners();
    if (planners.isEmpty) {
      await createPlannerWrtArtist("VanGogh");
      planners = await getPlanners();
    }
    for (var element in planners) {
      plannerContainers.add(
        Container(
          child: Dismissible(
            key: UniqueKey(),
            confirmDismiss: (direction) async {
              bool confirm = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor:  const Color.fromRGBO(231, 90, 124, 1),
                    title: Text(
                      "Confirmation",
                      style: TextStyle(
                          fontSize: deviceHeight * 0.02,
                          color: const Color.fromRGBO(242, 245, 234, 1)
                      ),
                    ),
                    content: Text(
                      "Are you sure you want to delete this item?",
                      style: TextStyle(
                          fontSize: deviceHeight * 0.02,
                          color: const Color.fromRGBO(242, 245, 234, 1)
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: deviceHeight * 0.017,
                            color: const Color.fromRGBO(242, 245, 234, 1)
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            fontSize: deviceHeight * 0.017,
                            color: const Color.fromRGBO(242, 245, 234, 1)
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
              return confirm ?? false;
            },
            onDismissed: (direction) async {
              // Handle dismissal, you can remove the item from the list or perform other actions
              await deletePlanner(element.id!);
            },
            background: Container(
              color: Colors.red,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: Container(
              width: double.infinity,
              height: deviceHeight * 0.08,
              padding: const EdgeInsets.all(2),
              child: ElevatedButton(
                style: raisedButtonStyle,
                onPressed: () async {
                  goToArtist(context, element.plannerArtist, element.id!, element.creationDate);
                },
                child: Text(
                  '${element.id}.) at ${element.creationDate} with ${element.plannerArtist}',
                  style: TextStyle(fontSize: deviceHeight * 0.02),
                ),
              ),
            ),
          ),
        ),
      );
    }
  } catch (e) {
    print('Error fetching planners: $e');
  }
  return plannerContainers;
}