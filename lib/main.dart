import 'package:devtools/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Pages/home_page/home_page.dart';
import 'widgets/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.lightBlue,
      cardColor: Colors.white,
      canvasColor: MyTheme.creamColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      bannerTheme: const MaterialBannerThemeData(
          backgroundColor: Colors.white, elevation: 0.0),
    ),
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
    routes: {
      MyRoute.homeRoute: (context) => const HomePage(),
    },
  ));
}
