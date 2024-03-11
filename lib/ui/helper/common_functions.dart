import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pomodoro2/main.dart';
import 'package:pomodoro2/screens/johannes_vermeer.dart';
import 'package:pomodoro2/ui/styles/common_styles.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../models/planner_model.dart';
import '../../provider/navbar_provider.dart';
import '../../provider/slider_provider.dart';
import '../../provider/task_provider.dart';
import '../../screens/cezanne.dart';
import '../../screens/gustav_klimt.dart';
import '../../screens/monet.dart';
import '../../screens/osman_hamdi.dart';
import '../../screens/picasso.dart';
import '../../screens/salvador_dali.dart';
import '../../screens/van_gogh.dart';
import '../../services/planner_service.dart';
import '../../services/task_service.dart';
import '../widgets/common_widgets.dart';
import 'common_variables.dart';
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
      case "JohannesVermeer":
        return JohannesVermeer(title: "JohannesVermeer", plannerId: plannerId, date: date);
      case "Cezanne":
        return Cezanne(title: "Cezanne", plannerId: plannerId, date: date);
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
Future<List<Container>> fetchPlanners(BuildContext context, double deviceHeight, Function setStateWhenDelete) async {
  final navbarProvider = Provider.of<NavbarProvider>(context, listen: false);
  List<Container> plannerContainers = [];
  try {
    var planners = await getPlanners();
    if (planners.isEmpty) {
      await createPlannerWrtArtist("VanGogh");
      planners = await getPlanners();
    }
    for (var element in planners) {
      DateTime creationDate = DateFormat('yMd').parse(element.creationDate);
      DateTime newDate = creationDate.add(Duration(days: 7));
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
              return confirm;
            },
            onDismissed: (direction) async {
              await deletePlanner(element.id!);
              setStateWhenDelete();
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
              height: deviceHeight,
              padding: const EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () async {
                    navbarProvider.hideNavbar();
                    goToArtist(context, element.plannerArtist, element.id!, element.creationDate);
                  },
                  child: Column(
                    children: [

                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: Image.asset(
                            "assets/images/${element.plannerArtist}/$chosenBackground.jpg",
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Text(
                            '${element.creationDate} - ${DateFormat('M/d/y').format(newDate)}',
                            textScaler: const TextScaler.linear(1.15),
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                      ),
                    ],
                  ),
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
String randomImageChooser(String artistName) {
  //int randomNumber = Random().nextInt(count) + 1;
  return "assets/images/$artistName/$chosenBackground.jpg";
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

Future<void> saveWorkedMinutes() async {
  if (TaskProvider.taskId != null) {
    final task = await getTask(TaskProvider.taskId!);
    int totalWork = task!.totalWorkMinutes;
    totalWork += SliderProvider.studyDurationSliderValue;
    task.totalWorkMinutes = totalWork;
    await _showCompletionDialog();
    await updateTask(task);
  }
}
Future<void> _showCompletionDialog() async {
  showSimpleNotification(
    duration: const Duration(seconds: 5),
    slideDismissDirection: DismissDirection.vertical,
    elevation: 4,
    const Text(
      "Working minutes saved successfully!",
      style: TextStyle(
        fontSize: 15,
        color: Colors.black,
      ),
    ),
    background: const Color.fromRGBO(242, 245, 234, 1),
  );
}



class ShimmerLoading extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  const ShimmerLoading({super.key, required this.isLoading, required this.child});
  @override
  Widget build(BuildContext context) {
    return isLoading ?
    Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[100]!,
      child: child,
    ) : child;
  }
}

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({super.key});
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        width: deviceWidth * 0.95,
        height: deviceHeight * 0.375,
        decoration: BoxDecoration(
          color: Colors.grey.shade300.withOpacity(0.6),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

class PlaceholderForPage extends StatelessWidget {
  const PlaceholderForPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 5),
        child: Column(
          children: [
            ShimmerContainer(),
            ShimmerContainer(),
            ShimmerContainer(),
          ],
        ),
      ),
    );
  }
}



class ShimmerAppBar extends StatelessWidget implements PreferredSizeWidget {
  ShimmerAppBar ({super.key, required this.isLoading, required this.colorList});
  bool isLoading;
  final List<Color> colorList;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: isLoading
          ? Shimmer.fromColors(
            baseColor: Colors.grey[350]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
                width: double.infinity,
                height: kToolbarHeight + MediaQuery.of(context).padding.top,
                color: Colors.grey.shade500
            ),
          )
          : AppBar(
        backgroundColor: colorList.last,
        elevation: 2,
        toolbarOpacity: 0.7,
        bottomOpacity: 0.5,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}