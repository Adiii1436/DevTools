import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'home_header.dart';
import 'home_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppTopBar(),
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const HomeHeader(),
          const HomeList().py16().expand(),
        ]),
      ),
    ));
  }

  AppBar AppTopBar() {
    return AppBar(
      leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            "assets/Icons/menu.png",
            width: 28,
          )),
      elevation: 0.0,
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: EdgeInsets.all(5),
          child: IconButton(
            onPressed: () {},
            icon: Image.asset("assets/Icons/user(1).png"),
          ),
        )
      ],
    );
  }
}
