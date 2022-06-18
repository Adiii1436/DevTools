import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widgets/themes.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late DateTime? myDateTime;
  String date = '';
  String todayDate = DateFormat('dd-MM-yy').format(DateTime.now());

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
              size: 43,
              color: Vx.gray400,
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
        ),
        const SizedBox(
          height: 40,
        ),
        Container(
          padding: const EdgeInsets.only(left: 51),
          child: Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: () async {
                  myDateTime = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2010),
                      lastDate: DateTime(2025));

                  setState(() {
                    date = DateFormat('dd-MM-yy').format(myDateTime!);
                  });
                },
                child: Container(
                  width: 135,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Vx.gray400),
                      borderRadius: BorderRadius.circular(25)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          color: Vx.gray500,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          date == '' || date == todayDate ? 'Today' : date,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Vx.gray500,
                              fontWeight: FontWeight.bold),
                        )
                      ]),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 44,
                height: 48,
                decoration: BoxDecoration(
                    border: Border.all(color: Vx.gray400),
                    shape: BoxShape.circle),
                child: Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.all(Vx.blue600),
                  value: true,
                  shape: const CircleBorder(),
                  onChanged: (bool? value) {},
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 100),
        Container(
          margin: const EdgeInsets.only(left: 130),
          child: Row(
            children: const [
              Icon(Icons.folder_open_sharp, size: 25, color: Vx.gray500),
              SizedBox(
                width: 35,
              ),
              Icon(
                Icons.dark_mode_outlined,
                size: 25,
                color: Vx.gray500,
              ),
              SizedBox(
                width: 35,
              ),
              Icon(
                Icons.flag_outlined,
                size: 25,
                color: Vx.gray500,
              )
            ],
          ),
        )
      ])),
    );
  }
}
