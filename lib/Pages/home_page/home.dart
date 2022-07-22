import 'package:devtools/Pages/authentication_page/login_page.dart';
import 'package:devtools/Pages/home_page/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: Firebase.initializeApp(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  final user = FirebaseAuth.instance.currentUser;
                  if (user == null) {
                    return const LoginPage(
                      notVerified: false,
                    );
                  } else if (!user.emailVerified) {
                    return const LoginPage(
                      notVerified: true,
                    );
                  } else if (user.emailVerified) {
                    return const HomePage();
                  }
                  return const Center(child: CircularProgressIndicator());
                default:
                  return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
