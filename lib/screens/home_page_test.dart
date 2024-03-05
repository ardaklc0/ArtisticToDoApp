import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/navbar_provider.dart';
import '../ui/helper/common_functions.dart';
import '../ui/helper/common_variables.dart';
import 'created_planners.dart';

class HomePageTest extends StatefulWidget {
  const HomePageTest({super.key});

  @override
  State<HomePageTest> createState() => _HomePageTestState();
}

class _HomePageTestState extends State<HomePageTest> {
  @override
  Widget build(BuildContext context) {
    final navbarProvider = Provider.of<NavbarProvider>(context);
    return MaterialApp(
      home: Scaffold(
        backgroundColor: homePageColor,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: ArtistButton(
                    imagePath: 'assets/images/GustavKlimt/1.jpg',
                    title: Text(
                      'Gustav Klimt',
                      textScaler: const TextScaler.linear(1.7),
                      style: GoogleFonts.roboto(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    onTap: () async {
                      BuildContext currentContext = context;
                      await createPlannerWrtArtist("GustavKlimt");
                      if (!context.mounted) return;
                      showDialog(
                        context: currentContext,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Success!'),
                            content: const Text('The planner is successfully added.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: ArtistButton(
                    imagePath: 'assets/images/Monet/1.jpg',
                    title: Text(
                      'Monet',
                      textScaler: const TextScaler.linear(1.7),
                      style: GoogleFonts.roboto(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    onTap: () async {
                      BuildContext currentContext = context;
                      await createPlannerWrtArtist("Monet");
                      if (!context.mounted) return;
                      showDialog(
                        context: currentContext,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Success!'),
                            content: const Text('The planner is successfully added.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: ArtistButton(
                    imagePath: 'assets/images/Picasso/2.jpg',
                    title: Text(
                      'Picasso',
                      textScaler: const TextScaler.linear(1.7),
                      style: GoogleFonts.roboto(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    onTap: () async {
                      BuildContext currentContext = context;
                      await createPlannerWrtArtist("Picasso");
                      if (!context.mounted) return;
                      showDialog(
                        context: currentContext,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Success!'),
                            content: const Text('The planner is successfully added.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: ArtistButton(
                    imagePath: 'assets/images/SalvadorDali/2.jpg',
                    title: Text(
                      'Dali',
                      textScaler: const TextScaler.linear(1.7),
                      style: GoogleFonts.roboto(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    onTap: () async {
                      BuildContext currentContext = context;
                      await createPlannerWrtArtist("SalvadorDali");
                      if (!context.mounted) return;
                      showDialog(
                        context: currentContext,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Success!'),
                            content: const Text('The planner is successfully added.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: ArtistButton(
                    imagePath: 'assets/images/OsmanHamdi/3.jpg',
                    title: Text(
                      'Osman Hamdi',
                      textScaler: const TextScaler.linear(1.7),
                      style: GoogleFonts.roboto(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    onTap: () async {
                      BuildContext currentContext = context;
                      await createPlannerWrtArtist("OsmanHamdi");
                      if (!context.mounted) return;
                      showDialog(
                        context: currentContext,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Success!'),
                            content: const Text('The planner is successfully added.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: ArtistButton(
                    imagePath: 'assets/images/VanGogh/2.jpg',
                    title: Text(
                      'Van Gogh',
                      textScaler: const TextScaler.linear(1.7),
                      style: GoogleFonts.roboto(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    onTap: () async {
                      BuildContext currentContext = context;
                      await createPlannerWrtArtist("VanGogh");
                      if (!context.mounted) return;
                      showDialog(
                        context: currentContext,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Success!'),
                            content: const Text('The planner is successfully added.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class ArtistButton extends StatefulWidget {
  ArtistButton({Key? key, required this.onTap, required this.imagePath, required this.title}) : super(key: key);

  final VoidCallback? onTap;
  final String imagePath;
  Widget title;

  @override
  State<ArtistButton> createState() => _ArtistButtonState();
}

class _ArtistButtonState extends State<ArtistButton> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      height: deviceWidth * 0.6,
      width: deviceWidth * 0.95,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: widget.onTap,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: widget.title
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  child: Image.asset(
                    widget.imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
