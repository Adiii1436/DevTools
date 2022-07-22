import 'package:devtools/Pages/home_page/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'home_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _pushToLoginpage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'DevTools',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white70,
          actions: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  _pushToLoginpage();
                },
                icon: const Icon(Icons.logout_rounded),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // const HomeHeader(),
              const HomeList().py16().expand(),
            ]),
          ),
        ));
  }
}
