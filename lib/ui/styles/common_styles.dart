import 'package:flutter/material.dart';

ButtonStyle raisedButtonStyle(Color? textColor, Color dateColor, double deviceHeight, double deviceWidth) => ElevatedButton.styleFrom(
  foregroundColor: textColor,
  backgroundColor: dateColor,
  fixedSize: Size(deviceWidth * 0.5, deviceHeight * 0.05),
  padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.1),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(deviceWidth * 0.05)),
  ),
);

TextStyle textStyle(Color? textColor, double deviceWidth) => TextStyle(
  color: textColor,
  fontSize: deviceWidth * 0.04 ,
);

TextStyle buttonTextStyle(double deviceWidth) => TextStyle(
  fontSize: deviceWidth * 0.035,
);

ButtonStyle get mainUiRaisedButtonStyle => ElevatedButton.styleFrom(
  foregroundColor: const Color.fromRGBO(44, 54, 63, 1),
  backgroundColor: const Color.fromRGBO(242, 245, 234, 1),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(0.0),
  ),
);