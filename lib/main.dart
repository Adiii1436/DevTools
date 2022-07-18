import 'package:devtools/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Pages/home_page/home_page.dart';
import 'widgets/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.lightTheme(context),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        MyRoute.homeRoute: (context) => const HomePage(),
      },
    );
  }
}
