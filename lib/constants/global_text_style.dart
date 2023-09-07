import 'package:adhd_planner/constants/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle buttonsStyle = GoogleFonts.spaceMono(
      textStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold));

  static TextStyle inputTextStyle = GoogleFonts.spaceMono(
      textStyle: const TextStyle(
          fontSize: 25, fontWeight: FontWeight.w200, color: Colors.grey));

  static TextStyle hintTextStyle = GoogleFonts.spaceMono(
      textStyle: TextStyle(
          color: mainAppPurpleColor,
          // shadows: <Shadow>[
          //   Shadow(
          //     offset: Offset(3.0, 3.0),
          //     blurRadius: 3.0,
          //     color: mainAppPurpleColor,
          //   ),
          // ],
          fontSize: 8,
          fontWeight: FontWeight.bold));

  static TextStyle greetingTextStyle = GoogleFonts.spaceMono(
    textStyle: TextStyle(
        fontSize: 75, fontWeight: FontWeight.w500, color: mainAppPurpleColor),
  );
}
