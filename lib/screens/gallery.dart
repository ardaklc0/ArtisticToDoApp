import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro2/main.dart';
import '../models/artist_header_model.dart';
import '../models/artist_model.dart';
import '../models/painting_model.dart';
import '../ui/helper/common_functions.dart';
import '../ui/helper/common_variables.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key});
  @override
  Widget build(BuildContext context) {
    String artistId = artistEntities[chosenArtist].artistId;
    String artistBirthDeath = '${artistEntities[chosenArtist].artistBirthDate!} - ${artistEntities[chosenArtist].artistDeathDate!}';
    String artistName = artistEntities[chosenArtist].name;
    String artistDescription = artistEntities[chosenArtist].artistDescription;
    String imagePath = artistEntities[chosenArtist].imagePath;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
        )
        ),
      );
  }
}