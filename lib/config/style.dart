import 'package:flutter/material.dart';

class Style {
  //Background Color
  static const backgroundColor = Color.fromRGBO(250, 250, 250, 1);
  //UI Color
  static const primaryColor = Color.fromRGBO(25, 99, 210, 1);
  static const secondaryColor = Color.fromRGBO(255, 255, 255, 1);
  static const deleteBtnColor = Color.fromRGBO(222, 53, 11, 1);
  static const counterBgColor = Color.fromRGBO(240, 243, 255, 1);
  static const counterBorderColor = Color.fromRGBO(219, 219, 219, 1);
  static const btnColor = Color.fromRGBO(0, 111, 253, 1);
  //TextField Color
  static const textFieldBorderColor = Color.fromRGBO(197, 198, 204, 1);
  static const textFieldIconColor = Color.fromRGBO(143, 144, 152, 1);
  //Font Color
  static const fontColorBlack = Color.fromRGBO(48, 48, 48, 1);
  static const textFieldPlaceholderColor = Color.fromRGBO(143, 144, 152, 1);

  //Font Style
  static const TextStyle textFieldPlaceholderStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 15,
    color: textFieldPlaceholderColor,
    height: 1.428,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const TextStyle headingInterStyle = TextStyle(
    fontFamily: 'Inter',
    color: fontColorBlack,
    height: 1.208,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 24,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    height: 1.21,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const TextStyle testPoppins = TextStyle(
    fontFamily: 'Poppins',
    height: 1,
  );
  static const TextStyle testRubik = TextStyle(
    fontFamily: 'Rubik',
    height: 1,
  );
}
