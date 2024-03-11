import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../models/artist_header_model.dart';
import '../../../screens/gallery.dart';
import '../../helper/common_functions.dart';

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
                onTap: () => gotoDetailsPage(context, 'assets/images/$artistId/$i.jpg'),
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