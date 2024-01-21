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
  foregroundColor: Colors.white,
  backgroundColor: Colors.black,
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

Future<List<ElevatedButton>> fetchPlanners(BuildContext context) async {
  List<ElevatedButton> plannerContainers = [];
  try {
    var planners = await getPlanners();
    if (planners.isEmpty) {
      await createPlannerWrtArtist("VanGogh");
      planners = await getPlanners();
    }
    for (var element in planners) {
      plannerContainers.add(
        ElevatedButton(
          style: raisedButtonStyle,
          onPressed: () async {
            goToArtist(context, element.plannerArtist, element.id!, element.creationDate);
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