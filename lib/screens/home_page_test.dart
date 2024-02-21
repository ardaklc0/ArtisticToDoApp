import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: const Color.fromRGBO(183, 211, 236, 1.0),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ArtistButton(
                    imagePath: 'assets/images/Gustav Klimt/1.jpg',
                    title: 'Gustav Klimt',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Planner has been added'),
                      ));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ArtistButton(
                    imagePath: 'assets/images/Monet/1.jpg',
                    title: 'Monet',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Planner has been added'),
                      ));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ArtistButton(
                    imagePath: 'assets/images/Picasso/1.jpg',
                    title: 'Picasso',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Planner has been added'),
                      ));
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
  final String title;

  @override
  State<ArtistButton> createState() => _ArtistButtonState();
}

class _ArtistButtonState extends State<ArtistButton> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: widget.onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: deviceWidth * 0.95,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            ClipRRect(
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
          ],
        ),
      ),
    );
  }
}
