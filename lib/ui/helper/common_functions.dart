import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pomodoro2/ui/styles/common_styles.dart';
import '../../models/planner_model.dart';
import '../../screens/gustav_klimt.dart';
import '../../screens/monet.dart';
import '../../screens/osman_hamdi.dart';
import '../../screens/picasso.dart';
import '../../screens/salvador_dali.dart';
import '../../screens/van_gogh.dart';
import '../../services/planner_service.dart';
import '../widgets/common_widgets.dart';
import 'common_variables.dart';
void goToArtist(BuildContext context, String artist, int plannerId, String date) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    switch (artist) {
      case "VanGogh":
        return VanGogh(title: "Van Gogh", plannerId: plannerId, date: date, randomImage: randomImageChooser("Van Gogh", 17));
      case "SalvadorDali":
        return SalvadorDali(title: "Salvador Dali", plannerId: plannerId, date: date, randomImage: randomImageChooser("Dali", 9));
      case "Picasso":
        return Picasso(title: "Picasso", plannerId: plannerId, date: date, randomImage: randomImageChooser("Picasso", 12));
      case "Monet":
        return Monet(title: "Monet", plannerId: plannerId, date: date, randomImage: randomImageChooser("Monet", 22));
      case "OsmanHamdi":
        return OsmanHamdi(title: "OsmanHamdi", plannerId: plannerId, date: date, randomImage: randomImageChooser("Osman Hamdi Bey", 11));
      case "GustavKlimt":
        return GustavKlimt(title: "GustavKlimt", plannerId: plannerId, date: date, randomImage: randomImageChooser("Gustav Klimt", 20));
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
                    backgroundColor: homePageColor,
                    title: dismissibleText("Confirmation", deviceHeight, dismissibleColor),
                    content: dismissibleText("Are you sure you want to delete this item?", deviceHeight, dismissibleColor),
                    actions: <Widget>[
                      dismissibleButton("Cancel", deviceHeight, dismissibleColor, false, context),
                      dismissibleButton("Delete", deviceHeight, dismissibleColor, true, context)
                    ],
                  );
                },
              );
              return confirm ?? false;
            },
            onDismissed: (direction) async {
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
                style: mainUiRaisedButtonStyle,
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
String randomImageChooser(String artistName, int count) {
  Random random = Random();
  int randomNumber = random.nextInt(count) + 1;
  return "assets/images/$artistName/$randomNumber.jpg";
}

List<Container> colorContainers(List<Color> colorList){
  List<Container> listBoxes = [];
  print(colorList);
  colorList.sort((a, b) {
    final hslA = HSLColor.fromColor(a);
    final hslB = HSLColor.fromColor(b);
    return hslA.lightness.compareTo(hslB.lightness);
  });
  print(colorList);
  colorList.forEach((element) {
    listBoxes.add(
        Container(
          width: 20,
          height: 20,
          color: Color.fromRGBO(element.red, element.green, element.blue, 1),
        )
    );
  });
  return listBoxes;
}
Future<List<Color>> sortedColors(String randomImage) async {
  List<Color> colorPalettes = [];
  final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(AssetImage(randomImage));
  paletteGenerator.paletteColors.forEach((element) {
    colorPalettes.add(element.color);
  });
  colorPalettes.sort((a, b) {
    final hslA = HSLColor.fromColor(a);
    final hslB = HSLColor.fromColor(b);
    return hslA.lightness.compareTo(hslB.lightness);
  });
  return colorPalettes;
}