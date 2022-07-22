import 'package:devtools/Pages/authentication_page/login_page.dart';
import 'package:devtools/Pages/home_page/home.dart';
import 'package:devtools/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Pages/home_page/home_page.dart';
import 'widgets/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
    home: const Home(),
    routes: {
      MyRoute.homeRoute: (context) => const HomePage(),
      MyRoute.loginRoute: ((context) => const LoginPage(
            notVerified: false,
          ))
    },
  ));
}
