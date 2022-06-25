// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:devtools/Pages/todo_list_page.dart/categories.dart';
import '../../widgets/themes.dart';

class AddTaskCategory extends StatefulWidget {
  final DocumentSnapshot category;

  const AddTaskCategory({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<AddTaskCategory> createState() => _AddTaskCategoryState();
}

class _AddTaskCategoryState extends State<AddTaskCategory> {
  final TextEditingController task = TextEditingController();

  DateTime? myDateTime;
  String date = '';
  String todayDate = DateFormat('dd-MM-yy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final docId = widget.category['category'];
    final ref = FirebaseFirestore.instance
        .collection('devTools_categories')
        .doc(docId)
        .collection("$docId list");
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 30, right: 20),
        width: 150,
        height: 60,
        child: FloatingActionButton.extended(
            backgroundColor: Vx.blue600,
            elevation: 0.0,
            label: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('New Task', style: TextStyle(color: Colors.white)),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.white,
                )
              ],
            ),
            onPressed: () {
              ref.add({
                'task': task.text,
                'Date': date == '' ? todayDate : date,
                'category': widget.category['category'],
                'status': false
              }).whenComplete(() => Navigator.pop(context));
            }),
      ),
      backgroundColor: MyTheme.creamColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            margin: const EdgeInsets.only(left: 270),
            child: InkWell(
              borderRadius: BorderRadius.circular(180),
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Vx.gray400)),
                  child: const Text(
                    "×",
                    style: TextStyle(fontSize: 33, color: Vx.gray600),
                  )),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            margin: const EdgeInsets.only(left: 55),
            child: TextField(
                controller: task,
                cursorColor: Colors.black38,
                style: const TextStyle(fontSize: 25, color: Colors.black),
                decoration: const InputDecoration(
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
                        border: Border.all(color: Vx.gray300),
                        borderRadius: BorderRadius.circular(25)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            color: Vx.gray400,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            date == '' || date == todayDate ? 'Today' : date,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Vx.gray400,
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
                      border: Border.all(color: Vx.gray300),
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
              children: [
                IconButton(
                    splashRadius: 25,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const AddCategories())));
                    },
                    icon: const Icon(Icons.folder_open_sharp,
                        size: 25, color: Vx.gray500)),
                const SizedBox(
                  width: 35,
                ),
                const Icon(
                  Icons.dark_mode_outlined,
                  size: 25,
                  color: Vx.gray500,
                ),
                const SizedBox(
                  width: 35,
                ),
                const Icon(
                  Icons.flag_outlined,
                  size: 25,
                  color: Vx.gray500,
                )
              ],
            ),
          ),
          // const SizedBox(
          //   height: 90,
          // ),
          // Container(
          //   width: 270,
          //   child: Text(
          //     "If you'll create a task for future then it will show up on the dashboard on that particular day.",
          //     style: TextStyle(fontSize: 12, color: Vx.gray500),
          //   ),
          // )
        ]),
      )),
    );
  }
}
