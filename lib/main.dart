import 'package:devtools/Pages/notebook_page.dart';
import 'package:devtools/home_widgets/themes.dart';
import 'package:devtools/home_widgets/routes.dart';
import 'package:flutter/material.dart';
// import 'package:velocity_x/velocity_x.dart';
import 'Pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.lightTheme(context),
      // darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        MyRoute.homeRoute: (context) => const HomePage(),
        MyRoute.notebookRoute: (context) => const NoteBookPage(),
      },
    );
  }
}
