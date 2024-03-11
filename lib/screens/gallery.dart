import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ui/helper/common_variables.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: homePageColor,
        body: ArtistHeader(
          artistBirthDeath: '${artists[0].artistBirthDate!} - ${artists[0].artistDeathDate!}',
          artistName: artists[0].name,
          artistDescription: artists[0].artistDescription,
          imagePath: artists[0].imagePath,
          title: Text(
            artists[0].name,
            textScaler: const TextScaler.linear(1.2),
            style: GoogleFonts.roboto(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
            ),
          ),
          onTap: () => _gotoDetailsPage(context, artists[0].imagePath),
        )
        ),
      );
  }
}

void _gotoDetailsPage(BuildContext context, String imagePath) {
  Navigator.of(context).push(MaterialPageRoute<void>(
    builder: (BuildContext context) => Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: homePageColor,
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              imagePath,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.3),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Center(
            child: Hero(
              tag: 'gallery',
              child: ClipRRect(
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ]
      ),
    ),
  ));
}

class Artist {
  final String name;
  final String imagePath;
  final String artistId;
  final String artistDescription;
  final String? artistBirthDate;
  final String? artistDeathDate;
  Artist({
    required this.name,
    required this.imagePath,
    required this.artistId,
    required this.artistDescription,
    this.artistBirthDate,
    this.artistDeathDate,
  });
}
List<Artist> artists = [
  Artist(
      name: 'Gustav Klimt',
      imagePath: 'assets/images/GustavKlimt/1.jpg',
      artistId: 'GustavKlimt',
      artistDescription:
          'Gustav Klimt was an Austrian symbolist painter'
          ' and one of the most prominent members of'
          ' the Vienna Secession movement. Klimt is noted'
          ' for his paintings, murals, sketches, and '
          'other objets d\'art. Klimt\'s primary subject',
      artistBirthDate: 'July, 1862',
      artistDeathDate: 'February, 1918',
  ),
  //Artist(name: 'Monet', imagePath: 'assets/images/Monet/1.jpg', artistId: 'Monet'),
  //Artist(name: 'Picasso', imagePath: 'assets/images/Picasso/1.jpg', artistId: 'Picasso'),
  //Artist(name: 'Dali', imagePath: 'assets/images/SalvadorDali/1.jpg', artistId: 'SalvadorDali'),
  //Artist(name: 'Osman Hamdi', imagePath: 'assets/images/OsmanHamdi/1.jpg', artistId: 'OsmanHamdi'),
  //Artist(name: 'Van Gogh', imagePath: 'assets/images/VanGogh/1.jpg', artistId: 'VanGogh'),
  //Artist(name: 'Jan Vermeer', imagePath: 'assets/images/JohannesVermeer/1.jpg', artistId: 'JohannesVermeer'),
  //Artist(name: 'Cezanne', imagePath: 'assets/images/Cezanne/1.jpg', artistId: 'Cezanne'),
];
class ArtistHeader extends StatelessWidget {
  final VoidCallback? onTap;
  final String imagePath;
  final Widget title;
  final String artistName;
  final String artistBirthDeath;
  final String artistDescription;
  const ArtistHeader({
    Key? key,
    required this.onTap,
    required this.imagePath,
    required this.title,
    required this.artistName,
    required this.artistBirthDeath,
    required this.artistDescription,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: onTap,
              child: Image.asset(
                imagePath,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Text(artistName, style: GoogleFonts.roboto(fontStyle: FontStyle.italic, fontWeight: FontWeight.w400, fontSize: 30)),
            Text(artistBirthDeath, style: GoogleFonts.roboto(fontStyle: FontStyle.italic, fontWeight: FontWeight.w400, fontSize: 20)),
            Text(artistDescription, style: GoogleFonts.roboto(fontStyle: FontStyle.italic, fontWeight: FontWeight.w400, fontSize: 20)),
            Text("Look at artist's paintings. Deep dive into more details!", style: GoogleFonts.roboto(fontStyle: FontStyle.normal, fontWeight: FontWeight.w600, fontSize: 20)),
            slideWidget(deviceHeight),
          ],
        ),
      ),
    );
  }
}

Widget slideWidget(double deviceHeight) => CarouselSlider(
  options: CarouselOptions(
    height: deviceHeight * 0.5,
    autoPlay: false,
    aspectRatio: 2.0,
    enlargeCenterPage: true,
  ),
  items: [1,2,3,4,5,6,7,8,9,10].map((i) {
    return Builder(
      builder: (BuildContext context) {
        return InkWell(
            child: Image.asset(
              'assets/images/GustavKlimt/$i.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
          ),
          onTap: () => _gotoDetailsPage(context, 'assets/images/GustavKlimt/$i.jpg')
        );
      },
    );
  }).toList(),
);