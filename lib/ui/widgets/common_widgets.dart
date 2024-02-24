import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../helper/common_variables.dart';
import '../styles/common_styles.dart';
const Icon homeIconForFloatingActionButton =  Icon(
  color: homeIconFillingColor,
  homeIcon
);
Widget partOfTaskContainer(double deviceWidth, double constantWidth, String dayText, Color? textColor) => Padding(
  padding: fixedEdgeInsets,
  child: SizedBox(
    width: deviceWidth * widthOfDayInDateContainer,
    child: Text(
      textAlign: TextAlign.center,
      dayText,
      style: GoogleFonts.roboto(
        fontSize: deviceWidth * 0.045,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        textStyle: textStyle(textColor, deviceWidth)
      ),
      overflow: TextOverflow.fade,
    ),
  ),
);
Widget dismissibleText(String text, double deviceHeight, Color dismissibleColor) => Text(
  text,
  style: TextStyle(
      fontSize: deviceHeight * 0.017,
      color: dismissibleColor
  ),
);
Widget showWorkedMinutes(double deviceHeight, int workedMinutes) => Text(
  'Worked for $workedMinutes minutes',
  style: TextStyle(
      fontSize: deviceHeight * 0.017,
      color: Colors.black
  ),
);
Widget dismissibleButton(String text, double deviceHeight, Color dismissibleColor, bool returnValue, BuildContext context) => TextButton(
  onPressed: () {
    Navigator.of(context).pop(returnValue);
  },
  child: dismissibleText(text, deviceHeight, dismissibleColor),
);