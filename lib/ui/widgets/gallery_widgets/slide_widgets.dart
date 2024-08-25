import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../helper/common_functions.dart';

Future<List<int>> getNumberListWrtFolder(String artistId) async {
  Directory folder = Directory('assets/images/$artistId');
  List<FileSystemEntity> items = await folder.list().toList();
  return List.generate(items.length, (index) => index + 1);
}

Future<Widget> slideWidget(double deviceHeight, String artistId) async {
  return CarouselSlider(
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
            child: InkWell(
              child: Image.asset(
                'assets/images/$artistId/$i.jpg',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              onTap: () => gotoDetailsPage(context, 'assets/images/$artistId/$i.jpg'),
            ),
          );
        },
      );
    }).toList(),
  );
}