import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                      style: GoogleFonts.roboto(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300,
                        textStyle: const TextStyle(
                            fontSize: 25,
                            color: Colors.black
                        ),
                      ),
                    ),
                    onTap: () async {
                      await createPlannerWrtArtist("GustavKlimt");
                      goToCreatedPlanners();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: ArtistButton(
                    imagePath: 'assets/images/Monet/1.jpg',
                    title: Text(
                      'Monet',
                      style: GoogleFonts.roboto(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300,
                        textStyle: const TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                        ),
                      ),
                    ),
                    onTap: () async {
                      await createPlannerWrtArtist("Monet");
                      goToCreatedPlanners();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: ArtistButton(
                    imagePath: 'assets/images/Picasso/2.jpg',
                    title: Text(
                      'Picasso',
                      style: GoogleFonts.roboto(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300,
                        textStyle: const TextStyle(
                            fontSize: 25,
                            color: Colors.black
                        ),
                      ),
                    ),
                    onTap: () async {
                      await createPlannerWrtArtist("Picasso");
                      goToCreatedPlanners();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: ArtistButton(
                    imagePath: 'assets/images/SalvadorDali/2.jpg',
                    title: Text(
                      'Dali',
                      style: GoogleFonts.roboto(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300,
                        textStyle: const TextStyle(
                            fontSize: 25,
                            color: Colors.black
                        ),
                      ),
                    ),
                    onTap: () async {
                      await createPlannerWrtArtist("SalvadorDali");
                      goToCreatedPlanners();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: ArtistButton(
                    imagePath: 'assets/images/OsmanHamdi/3.jpg',
                    title: Text(
                      'Osman Hamdi',
                      style: GoogleFonts.roboto(

                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300,
                        textStyle: const TextStyle(

                            fontSize: 25,
                            color: Colors.black
                        ),
                      ),
                    ),
                    onTap: () async {
                      await createPlannerWrtArtist("OsmanHamdi");
                      goToCreatedPlanners();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: ArtistButton(
                    imagePath: 'assets/images/VanGogh/2.jpg',
                    title: Text(
                        'Van Gogh',
                        style: GoogleFonts.roboto(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300,
                          textStyle: const TextStyle(
                              fontSize: 25,
                              color: Colors.black
                        ),
                      ),
                    ),
                    onTap: () async {
                      await createPlannerWrtArtist("VanGogh");
                      goToCreatedPlanners();
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
  void goToCreatedPlanners() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const CreatedPlanners();
    }));
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
