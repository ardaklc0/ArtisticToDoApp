import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro2/models/painting_model.dart';
import '../ui/widgets/gallery_widgets/slide_widgets.dart';

class ArtistHeader extends StatelessWidget {
  final VoidCallback? onTap;
  final String imagePath;
  final Widget title;
  final String artistId;
  final String artistName;
  final String artistBirthDeath;
  final String artistDescription;
  const ArtistHeader({
    Key? key,
    required this.onTap,
    required this.imagePath,
    required this.title,
    required this.artistId,
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
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                artistName,
                style: GoogleFonts.roboto(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                ),
                textScaler: const TextScaler.linear(1.5),
              ),
            ),
            Text(
              artistBirthDeath,
              style: GoogleFonts.roboto(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.5)
              ),
              textScaler: const TextScaler.linear(1.1),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                artistDescription,
                style: GoogleFonts.roboto(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.justify,
                textScaler: const TextScaler.linear(1.15),
              ),
            ),
            FutureBuilder(
              future: slideWidget(deviceHeight, artistId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return snapshot.data ?? Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
Map<String, List<Painting>> paintingsPerArtist = {
  'GustavKlimt': [
    Painting(name: 'GustavLorem1', description: 'GustavIpsum'),
    Painting(name: 'GustavLorem2', description: 'GustavIpsum'),
    Painting(name: 'GustavLorem3', description: 'GustavIpsum'),
    Painting(name: 'GustavLorem4', description: 'GustavIpsum'),
    Painting(name: 'GustavLorem5', description: 'GustavIpsum'),
    Painting(name: 'GustavLorem6', description: 'GustavIpsum'),
    Painting(name: 'GustavLorem7', description: 'GustavIpsum'),
    Painting(name: 'GustavLorem8', description: 'GustavIpsum'),
    Painting(name: 'GustavLorem9', description: 'GustavIpsum'),
    Painting(name: 'GustavLorem10', description: 'GustavIpsum'),
  ],
  'Monet': [
    Painting(name: 'MonetLorem1', description: 'MonetIpsum'),
    Painting(name: 'MonetLorem2', description: 'MonetIpsum'),
    Painting(name: 'MonetLorem3', description: 'MonetIpsum'),
    Painting(name: 'MonetLorem4', description: 'MonetIpsum'),
    Painting(name: 'MonetLorem5', description: 'MonetIpsum'),
    Painting(name: 'MonetLorem6', description: 'MonetIpsum'),
    Painting(name: 'MonetLorem7', description: 'MonetIpsum'),
    Painting(name: 'MonetLorem8', description: 'MonetIpsum'),
    Painting(name: 'MonetLorem9', description: 'MonetIpsum'),
    Painting(name: 'MonetLorem10', description: 'MonetIpsum'),
  ],
  'Picasso': [
    Painting(name: 'PicassoLorem1', description: 'PicassoIpsum'),
    Painting(name: 'PicassoLorem2', description: 'PicassoIpsum'),
    Painting(name: 'PicassoLorem3', description: 'PicassoIpsum'),
    Painting(name: 'PicassoLorem4', description: 'PicassoIpsum'),
    Painting(name: 'PicassoLorem5', description: 'PicassoIpsum'),
    Painting(name: 'PicassoLorem6', description: 'PicassoIpsum'),
    Painting(name: 'PicassoLorem7', description: 'PicassoIpsum'),
    Painting(name: 'PicassoLorem8', description: 'PicassoIpsum'),
    Painting(name: 'PicassoLorem9', description: 'PicassoIpsum'),
    Painting(name: 'PicassoLorem10', description: 'PicassoIpsum'),
  ],
  'SalvadorDali': [
    Painting(name: 'SalvadorDaliLorem1', description: 'SalvadorDaliIpsum'),
    Painting(name: 'SalvadorDaliLorem2', description: 'SalvadorDaliIpsum'),
    Painting(name: 'SalvadorDaliLorem3', description: 'SalvadorDaliIpsum'),
    Painting(name: 'SalvadorDaliLorem4', description: 'SalvadorDaliIpsum'),
    Painting(name: 'SalvadorDaliLorem5', description: 'SalvadorDaliIpsum'),
    Painting(name: 'SalvadorDaliLorem6', description: 'SalvadorDaliIpsum'),
    Painting(name: 'SalvadorDaliLorem7', description: 'SalvadorDaliIpsum'),
    Painting(name: 'SalvadorDaliLorem8', description: 'SalvadorDaliIpsum'),
    Painting(name: 'SalvadorDaliLorem9', description: 'SalvadorDaliIpsum'),
    Painting(name: 'SalvadorDaliLorem10', description: 'SalvadorDaliIpsum'),
  ],
  'OsmanHamdi': [
    Painting(name: 'OsmanHamdiLorem1', description: 'OsmanHamdiIpsum'),
    Painting(name: 'OsmanHamdiLorem2', description: 'OsmanHamdiIpsum'),
    Painting(name: 'OsmanHamdiLorem3', description: 'OsmanHamdiIpsum'),
    Painting(name: 'OsmanHamdiLorem4', description: 'OsmanHamdiIpsum'),
    Painting(name: 'OsmanHamdiLorem5', description: 'OsmanHamdiIpsum'),
    Painting(name: 'OsmanHamdiLorem6', description: 'OsmanHamdiIpsum'),
    Painting(name: 'OsmanHamdiLorem7', description: 'OsmanHamdiIpsum'),
    Painting(name: 'OsmanHamdiLorem8', description: 'OsmanHamdiIpsum'),
    Painting(name: 'OsmanHamdiLorem9', description: 'OsmanHamdiIpsum'),
    Painting(name: 'OsmanHamdiLorem10', description: 'OsmanHamdiIpsum'),
  ],
  'VanGogh': [
    Painting(name: 'VanGoghLorem1', description: 'VanGoghIpsum'),
    Painting(name: 'VanGoghLorem2', description: 'VanGoghIpsum'),
    Painting(name: 'VanGoghLorem3', description: 'VanGoghIpsum'),
    Painting(name: 'VanGoghLorem4', description: 'VanGoghIpsum'),
    Painting(name: 'VanGoghLorem5', description: 'VanGoghIpsum'),
    Painting(name: 'VanGoghLorem6', description: 'VanGoghIpsum'),
    Painting(name: 'VanGoghLorem7', description: 'VanGoghIpsum'),
    Painting(name: 'VanGoghLorem8', description: 'VanGoghIpsum'),
    Painting(name: 'VanGoghLorem9', description: 'VanGoghIpsum'),
    Painting(name: 'VanGoghLorem10', description: 'VanGoghIpsum'),
  ],
  'JohannesVermeer': [
    Painting(name: 'JohannesVermeerLorem1', description: 'JohannesVermeerIpsum'),
    Painting(name: 'JohannesVermeerLorem2', description: 'JohannesVermeerIpsum'),
    Painting(name: 'JohannesVermeerLorem3', description: 'JohannesVermeerIpsum'),
    Painting(name: 'JohannesVermeerLorem4', description: 'JohannesVermeerIpsum'),
    Painting(name: 'JohannesVermeerLorem5', description: 'JohannesVermeerIpsum'),
    Painting(name: 'JohannesVermeerLorem6', description: 'JohannesVermeerIpsum'),
    Painting(name: 'JohannesVermeerLorem7', description: 'JohannesVermeerIpsum'),
    Painting(name: 'JohannesVermeerLorem8', description: 'JohannesVermeerIpsum'),
    Painting(name: 'JohannesVermeerLorem9', description: 'JohannesVermeerIpsum'),
    Painting(name: 'JohannesVermeerLorem10', description: 'JohannesVermeerIpsum'),
  ],
  'Cezanne': [
    Painting(name: 'CezanneLorem1', description: 'CezanneIpsum'),
    Painting(name: 'CezanneLorem2', description: 'CezanneIpsum'),
    Painting(name: 'CezanneLorem3', description: 'CezanneIpsum'),
    Painting(name: 'CezanneLorem4', description: 'CezanneIpsum'),
    Painting(name: 'CezanneLorem5', description: 'CezanneIpsum'),
    Painting(name: 'CezanneLorem6', description: 'CezanneIpsum'),
    Painting(name: 'CezanneLorem7', description: 'CezanneIpsum'),
    Painting(name: 'CezanneLorem8', description: 'CezanneIpsum'),
    Painting(name: 'CezanneLorem9', description: 'CezanneIpsum'),
    Painting(name: 'CezanneLorem10', description: 'CezanneIpsum'),
  ]
};