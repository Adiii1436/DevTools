import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widgets/themes.dart';

class AddTask extends StatelessWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.creamColor,
      body: SafeArea(
          child: Column(children: [
        const SizedBox(
          height: 50,
        ),
        Container(
            padding: const EdgeInsets.all(30),
            alignment: Alignment.centerRight,
            child: const Icon(
              CupertinoIcons.xmark_circle,
              size: 45,
              color: Vx.gray500,
            )),
        const SizedBox(
          height: 50,
        ),
        Container(
          margin: const EdgeInsets.only(left: 55),
          child: const TextField(
              cursorColor: Colors.black38,
              style: TextStyle(fontSize: 25, color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'Enter a new task',
                hintStyle: TextStyle(
                  color: Colors.black26,
                ),
              )),
        )
      ])),
    );
  }
}
