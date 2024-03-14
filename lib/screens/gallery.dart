import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro2/main.dart';
import '../models/artist_header_model.dart';
import '../models/artist_model.dart';
import '../models/painting_model.dart';
import '../ui/helper/common_functions.dart';
import '../ui/helper/common_variables.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  int chosenArtistIndex = chosenArtist;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    String artistId = artistEntities[chosenArtistIndex].artistId;
    String artistBirthDeath = '${artistEntities[chosenArtistIndex].artistBirthDate!} - ${artistEntities[chosenArtistIndex].artistDeathDate!}';
    String artistName = artistEntities[chosenArtistIndex].name;
    String artistDescription = artistEntities[chosenArtistIndex].artistDescription;
    String imagePath = artistEntities[chosenArtistIndex].imagePath;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        drawer: _drawer(context, artistId, _updateChosenArtist),
        backgroundColor: homePageColor,
        body: ArtistHeader(
          artistId: artistId,
          artistBirthDeath: artistBirthDeath,
          artistName: artistName,
          artistDescription: artistDescription,
          imagePath: imagePath,
          title: Text(
            artistName,
            textScaler: const TextScaler.linear(1.2),
            style: GoogleFonts.roboto(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
            ),
          ),
          onTap: () => gotoDetailsPage(context, imagePath),
        ),
      ),
    );
  }
  void _updateChosenArtist(int index) {
    setState(() {
      chosenArtistIndex = index;
    });
    _scaffoldKey.currentState?.closeDrawer();
  }
}

List<ListTile> _listTiles(BuildContext context, Function(int) updateCallback) {
  List<ListTile> listTiles = [];
  for (int i = 0; i < artistEntities.length; i++) {
    listTiles.add(
      ListTile(
        title: Text(artistEntities[i].name),
        onTap: () {
          updateCallback(i);
        },
      ),
    );
  }
  return listTiles;
}

Drawer _drawer(BuildContext context, String artistId, Function(int) updateCallback) => Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      SizedBox(
        height: 200,
        child: Image.asset(
          'assets/images/$artistId/3.jpg',
          fit: BoxFit.cover,
        ),
      ),
      ..._listTiles(context, updateCallback)
    ],
  ),
);
