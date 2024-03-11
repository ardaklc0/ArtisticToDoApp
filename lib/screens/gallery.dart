import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro2/main.dart';
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
          artistId: artists[chosenArtist].artistId,
          artistBirthDeath: '${artists[chosenArtist].artistBirthDate!} - ${artists[chosenArtist].artistDeathDate!}',
          artistName: artists[chosenArtist].name,
          artistDescription: artists[chosenArtist].artistDescription,
          imagePath: artists[chosenArtist].imagePath,
          title: Text(
            artists[chosenArtist].name,
            textScaler: const TextScaler.linear(1.2),
            style: GoogleFonts.roboto(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
            ),
          ),
          onTap: () => _gotoDetailsPage(context, artists[chosenArtist].imagePath),
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
class Painting {
  final String name;
  final String description;
  Painting({
    required this.name,
    required this.description
  });
}
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
            slideWidget(deviceHeight, artistId),
          ],
        ),
      ),
    );
  }
}

Widget slideWidget(double deviceHeight, String artistId) => CarouselSlider(
  options: CarouselOptions(
    autoPlay: false,
    aspectRatio: 1.5,
    enlargeCenterPage: true,
  ),
  items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((i) {
    return Builder(
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              InkWell(
                child: Image.asset(
                  'assets/images/$artistId/$i.jpg',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                onTap: () => _gotoDetailsPage(context, 'assets/images/$artistId/$i.jpg'),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.black.withOpacity(0.7),
                child: Text(
                  paintingsPerArtist[artistId]!.elementAt(i-1).name,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }).toList(),
);


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
  Artist(
    name: 'Monet',
    imagePath: 'assets/images/Monet/1.jpg',
    artistId: 'Monet',
    artistDescription: 'Oscar-Claude Monet was a French painter'
        ' and founder of impressionist painting who is'
        ' seen as a key precursor to modernism, especially'
        ' in his attempts to paint nature as he perceived it.',
    artistBirthDate: 'November, 1840',
    artistDeathDate: 'December, 1926',
  ),
  Artist(
    name: 'Picasso',
    imagePath: 'assets/images/Picasso/1.jpg',
    artistId: 'Picasso',
    artistDescription: 'Pablo Ruiz Picasso was a Spanish painter,'
        ' sculptor, printmaker, ceramicist and theatre designer'
        ' who spent most of his adult life in France. Regarded as'
        ' one of the most influential artists of the 20th century,'
        ' he is known for co-founding the Cubist movement, the'
        ' invention of constructed sculpture, the co-invention of'
        ' collage, and for the wide variety of styles that he helped'
        ' develop and explore.',
    artistBirthDate: 'October, 1881',
    artistDeathDate: 'April, 1973',
  ),
  Artist(
    name: 'Dali',
    imagePath: 'assets/images/SalvadorDali/1.jpg',
    artistId: 'SalvadorDali',
    artistDescription: 'Salvador Domingo Felipe Jacinto Dalí i Domènech,'
        ' 1st Marquis of Dalí de Púbol was a Spanish surrealist artist'
        ' renowned for his technical skill, precise draftsmanship and'
        ' the striking and bizarre images in his work. Born in Figueres,'
        ' Catalonia, Dalí received his formal education in fine arts at'
        ' Madrid. Influenced by Impressionism and the Renaissance masters'
        ' from a young age, he became increasingly attracted to Cubism and'
        ' avant-garde movements.',
    artistBirthDate: 'May, 1904',
    artistDeathDate: 'January, 1989',
  ),
  Artist(
    name: 'Osman Hamdi',
    imagePath: 'assets/images/OsmanHamdi/1.jpg',
    artistId: 'OsmanHamdi',
    artistDescription: 'Osman Hamdi Bey was an Ottoman administrator,'
        ' intellectual, art expert and also a prominent and pioneering'
        ' painter. He was also an accomplished archaeologist, and is'
        ' considered as the pioneer of the museum curator\'s profession'
        ' in Turkey. He was the founder of Istanbul Archaeology Museums'
        ' and of the Istanbul Academy of Fine Arts (Sanayi-i Nefise Mekteb-i'
        ' Alisi), known today as the Mimar Sinan University of Fine Arts.',
    artistBirthDate: 'December, 1842',
    artistDeathDate: 'February, 1910',
  ),
  Artist(
    name: 'Van Gogh',
    imagePath: 'assets/images/VanGogh/1.jpg',
    artistId: 'VanGogh',
    artistDescription: 'Vincent Willem van Gogh was a Dutch post-impressionist'
        ' painter who is among the most famous and influential figures in the'
        ' history of Western art. In just over a decade, he created about 2,100'
        ' artworks, including around 860 oil paintings, most of which date from'
        ' the last two years of his life. They include landscapes, still lifes,'
        ' portraits and self-portraits, and are characterised by bold colours and'
        ' dramatic, impulsive and expressive brushwork that contributed to the foundations'
        ' of modern art.',
    artistBirthDate: 'March, 1853',
    artistDeathDate: 'July, 1890',
  ),
  Artist(
    name: 'Jan Vermeer',
    imagePath: 'assets/images/JohannesVermeer/1.jpg',
    artistId: 'JohannesVermeer',
    artistDescription: 'Johannes Vermeer was a Dutch Baroque Period painter who'
        ' specialized in domestic interior scenes of middle-class life. During his'
        ' lifetime, he was a moderately successful provincial genre painter, recognized'
        ' in Delft and The Hague. Nonetheless, he produced relatively few paintings and'
        ' evidently was not wealthy, leaving his wife and children in debt at his death.',
    artistBirthDate: 'October, 1632',
    artistDeathDate: 'December, 1675',
  ),
  Artist(
    name: 'Cezanne',
    imagePath: 'assets/images/Cezanne/1.jpg',
    artistId: 'Cezanne',
    artistDescription: 'Paul Cézanne was a French artist and Post-Impressionist painter'
        ' whose work laid the foundations of the transition from the 19th-century conception'
        ' of artistic endeavor to a new and radically different world of art in the 20th century.'
        ' Cézanne\'s often repetitive, exploratory brushstrokes are highly characteristic and'
        ' clearly recognizable. He used planes of colour and small brushstrokes that build up to'
        ' form complex fields, at once both a direct expression of the sensations of the observing'
        ' eye and an abstraction from observed nature.',
    artistBirthDate: 'January, 1839',
    artistDeathDate: 'October, 1906',
  ),
];
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