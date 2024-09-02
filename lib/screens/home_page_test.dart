import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/navbar_provider.dart';
import '../ui/helper/common_functions.dart';
import '../ui/helper/common_variables.dart';

class HomePageTest extends StatelessWidget {
  const HomePageTest({super.key});
  @override
  Widget build(BuildContext context) {
    final navbarProvider = Provider.of<NavbarProvider>(context, listen: false);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: homePageColor,
        body: GridView.builder(
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 4,
            repeatPattern: QuiltedGridRepeatPattern.inverted,
            pattern: [
              const QuiltedGridTile(3, 2),
              const QuiltedGridTile(2, 2),
            ],
          ),
          itemCount: artists.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.all(5),
              child: ArtistButton(
                imagePath: artists[index].imagePath,
                title: Text(
                  artists[index].name,
                  textScaler: const TextScaler.linear(1.2),
                  style: GoogleFonts.roboto(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: () async {
                  //BuildContext currentContext = context;
                  DateTime dateTime = DateTime.now();
                  String dayFormat = DateFormat('yMd').format(dateTime).toString();
                  int id = await createPlannerWrtArtist(artists[index].artistId);
                  if (!context.mounted) return;
                  /*if (!context.mounted) return;
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
                  );*/
                  goToArtist(context, artists[index].artistId, id, dayFormat);
                  navbarProvider.hideNavbar();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class Artist {
  final String name;
  final String imagePath;
  final String artistId;
  Artist({
    required this.name,
    required this.imagePath,
    required this.artistId,
  });
}
List<Artist> artists = [
  Artist(name: 'Gustav Klimt', imagePath: 'assets/images/GustavKlimt/1.jpg', artistId: 'GustavKlimt'),
  Artist(name: 'Monet', imagePath: 'assets/images/Monet/1.jpg', artistId: 'Monet'),
  Artist(name: 'Picasso', imagePath: 'assets/images/Picasso/1.jpg', artistId: 'Picasso'),
  Artist(name: 'Dali', imagePath: 'assets/images/SalvadorDali/1.jpg', artistId: 'SalvadorDali'),
  Artist(name: 'Osman Hamdi', imagePath: 'assets/images/OsmanHamdi/1.jpg', artistId: 'OsmanHamdi'),
  Artist(name: 'Van Gogh', imagePath: 'assets/images/VanGogh/1.jpg', artistId: 'VanGogh'),
  Artist(name: 'Jan Vermeer', imagePath: 'assets/images/JohannesVermeer/1.jpg', artistId: 'JohannesVermeer'),
  Artist(name: 'Cezanne', imagePath: 'assets/images/Cezanne/1.jpg', artistId: 'Cezanne'),
  Artist(name: 'Edvard Munch', imagePath: 'assets/images/EdvardMunch/1.jpg', artistId: 'EdvardMunch'),
  Artist(name: 'Kandinsky', imagePath: 'assets/images/Kandinsky/1.jpg', artistId: 'Kandinsky'),
];
class ArtistButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String imagePath;
  final Widget title;
  const ArtistButton({
    super.key,
    required this.onTap,
    required this.imagePath,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: deviceWidth * 0.6,
      width: deviceWidth * 0.95,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: title,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
