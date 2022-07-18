import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        primarySwatch: Colors.lightBlue,
        cardColor: Colors.white,
        canvasColor: MyTheme.creamColor,
        fontFamily: GoogleFonts.poppins().fontFamily,
        bannerTheme: const MaterialBannerThemeData(
            backgroundColor: Colors.white, elevation: 0.0),
      );

  //colors
  static Color creamColor = const Color(0xfff5f5f5);
  static Color darkgrey = Vx.gray100;
  static Color darkBulish = const Color.fromARGB(255, 6, 6, 129);
  static Color mobileBackgroundColor = const Color.fromRGBO(0, 0, 0, 1);
  static Color webBackgroundColor = const Color.fromRGBO(18, 18, 18, 1);
  static Color mobileSearchColor = const Color.fromRGBO(38, 38, 38, 1);
  static Color blueColor = const Color.fromRGBO(0, 149, 246, 1);
  static Color primaryColor = Colors.white;
  static Color secondaryColor = Colors.grey;
}
