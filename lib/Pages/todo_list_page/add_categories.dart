import 'package:devtools/Pages/todo_list_page/todo_list.dart';
import 'package:devtools/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCategories extends StatefulWidget {
  const AddCategories({Key? key}) : super(key: key);

  @override
  State<AddCategories> createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {
  final ref = FirebaseFirestore.instance.collection('devTools_categories');

  DateTime? myDateTime;
  String date = '';
  String todayDate = DateFormat('dd-MM-yy').format(DateTime.now());
  final TextEditingController cate = TextEditingController();

  List<Color?> myColors = [
    Colors.red[600],
    Colors.green[600],
    Colors.deepPurple[600],
    Colors.blue[600],
    Colors.pink[600],
    Colors.brown[600]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.creamColor,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 30, right: 20),
        width: 170,
        height: 60,
        child: FloatingActionButton.extended(
            backgroundColor: Vx.blue600,
            elevation: 0.0,
            label: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('New Category', style: TextStyle(color: Colors.white)),
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
              ref.doc(cate.text).set({
                'task': '',
                'Date': date == '' ? todayDate : date,
                'category': cate.text,
                'status': false
              }).whenComplete(() => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TodoListPage())));
            }),
      ),
      body: SafeArea(
        child: Container(
          // decoration: BoxDecoration(color: Colors.pink),
          margin: const EdgeInsets.only(left: 17, right: 17),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: TextField(
                  controller: cate,
                  cursorColor: Colors.black38,
                  style: const TextStyle(fontSize: 25, color: Colors.black),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'New Category',
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    ),
                  )),
            ),
            Row(
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
                // Text("")
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ]),
        ),
      ),
    );
  }
}
