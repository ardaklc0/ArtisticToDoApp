import 'package:flutter/cupertino.dart';
import 'common_variables.dart';

class ImageContainer extends StatelessWidget {
  final String imageUrl;
  final Alignment imageAlignment;
  const ImageContainer({super.key, required this.imageUrl, required this.imageAlignment});
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: deviceHeight * Variables.heightProportionOfImageBox,
      width: deviceWidth,
      child: Image.asset(
        imageUrl,
        alignment: imageAlignment,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}


