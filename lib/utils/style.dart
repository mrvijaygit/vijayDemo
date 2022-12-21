import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'globals.dart';


class Styles {

  static TextStyle headingStyle1({Color color = Colors.black}) {
    return GoogleFonts.quicksand(
      color: color,
      fontWeight: FontWeight.w500,
      fontSize: 30,
    );
  }

  static TextStyle headingStyle2({Color color = Globals.dark}) {
    return GoogleFonts.quicksand(
      color: color,
      fontWeight: FontWeight.w700,
      fontSize: 20,
    );
  }

  static TextStyle headingStyle3({Color color = Globals.dark}) {
    return GoogleFonts.quicksand(
      color: color,
      fontWeight: FontWeight.w700,
      fontSize: 18,
    );
  }

  static TextStyle headingStyle4(
      {Color color = Globals.dark, bool isBold = false}) {
    return GoogleFonts.quicksand(
      color: color,
      fontSize: 16,
      fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
    );
  }

  static TextStyle headingStyle5(
      {Color color = Globals.dark, bool strike = false, bool isBold = false,double? fontSize}) {
    return GoogleFonts.quicksand(
      color: color,
      fontSize: fontSize??14,
      fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
      decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
      decorationThickness: strike ? 1.5 : 0,
    );
  }

  static TextStyle headingStyle6(
      {Color color = Globals.dark, bool isBold = false, bool strike = false}) {
    return GoogleFonts.quicksand(
      color: color,
      fontSize: 12,
      fontWeight: isBold ? FontWeight.w800 : FontWeight.w400,
      decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
    );
  }

  static TextStyle headingStyle7({
    Color color = Globals.dark,
    bool isBold = false,
    bool strike = false,
    bool underline = false,
  }) {
    return GoogleFonts.quicksand(
      color: color,
      fontSize: 10,
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
      decoration: strike
          ? TextDecoration.lineThrough
          : underline
          ? TextDecoration.underline
          : TextDecoration.none,
    );
  }

  static TextStyle headingStyle8(
      {Color color = Globals.dark, bool isBold = false, bool strike = false}) {
    return GoogleFonts.quicksand(
      color: color,
      fontSize: 7,
      fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
      decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
    );
  }

}
