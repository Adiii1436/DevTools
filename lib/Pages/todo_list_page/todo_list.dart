import 'dart:math';
import 'package:devtools/Pages/todo_list_page/add_task.dart';
import 'package:devtools/Pages/todo_list_page/category_list.dart';
import 'package:devtools/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final ref = FirebaseFirestore.instance.collection('devTools_todo');
  final ref1 = FirebaseFirestore.instance.collection('devTools_categories');
  final todayDate = DateFormat('dd-MM-yy').format(DateTime.now());

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
        margin: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          elevation: 0.0,
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddTask()))
                .then((value) => setState(
                      () {},
                    ));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        // toolbarHeight: 70,
        backgroundColor: MyTheme.creamColor,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Container(
          // decoration: BoxDecoration(color: Colors.pink),
          margin: const EdgeInsets.only(left: 17, right: 17, top: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "What's up, Aditya!",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "CATEGORIES",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Vx.gray500),
                ).py12().px1(),
                SizedBox(
                  height: 150,
                  child: StreamBuilder(
                      stream: ref1.snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        return GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio: 0.7 / 1),
                            itemCount: snapshot.hasData
                                ? snapshot.data?.docs.length
                                : 1,
                            itemBuilder: (context, index) {
                              Random random = Random();
                              Color? bg = myColors[random.nextInt(6)];
                              return snapshot.hasData
                                  ? InkWell(
                                      onTap: () {
                                        Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CategoryList(
                                                          category: snapshot
                                                              .data!.docs[index]
                                                              .data(),
                                                          bg: bg!,
                                                        )))
                                            .then((value) => setState(() {}));
                                      },
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(color: bg!),
                                            color: Colors.white),
                                        child: Text(
                                                snapshot.data!.docs[index]
                                                    ['category'],
                                                style: const TextStyle(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w600,
                                                    color: Vx.gray700))
                                            .px16(),
                                      ),
                                    )
                                  : Container(
                                      color: Colors.white,
                                    );
                            });
                      }),
                ),
                const Text(
                  "TODAY'S TASKS",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Vx.gray500),
                ).py12().px1(),
                Expanded(
                  child: StreamBuilder(
                      stream: ref.snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        final lengthDoc = snapshot.data?.docs.length;
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.hasData ? lengthDoc : 0,
                          itemBuilder: (context, index) {
                            Random random = Random();
                            Color? bg = myColors[random.nextInt(6)];
                            final task = snapshot.data?.docs[index]['task'];
                            final status = snapshot.data?.docs[index]['status'];
                            final category =
                                snapshot.data?.docs[index]['category'];
                            final date = snapshot.data?.docs[index]['Date'];
                            return Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.horizontal,
                              onDismissed: (direction) {
                                snapshot.data!.docs[index].reference.delete();
                              },
                              resizeDuration: const Duration(seconds: 2),
                              background: swipeBackground(task, category, date,
                                  status, snapshot.data!.docs[index].reference),
                              secondaryBackground: swipeBackground(
                                  task,
                                  category,
                                  date,
                                  status,
                                  snapshot.data!.docs[index].reference),
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                    // border: Border.all(color: bg!),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Checkbox(
                                      checkColor: Colors.white,
                                      fillColor: MaterialStateProperty.all(bg),
                                      value: snapshot.data!.docs[index]
                                          ['status'],
                                      shape: const CircleBorder(),
                                      onChanged: (bool? value) {
                                        snapshot.data!.docs[index].reference
                                            .update({
                                          'task': snapshot.data!.docs[index]
                                              ['task'],
                                          'Date': snapshot.data!.docs[index]
                                              ['Date'],
                                          'category': snapshot.data!.docs[index]
                                              ['category'],
                                          'status': value
                                        });
                                        setState(() {});
                                      },
                                    ),
                                    snapshot.data!.docs[index]['status']
                                        ? SizedBox(
                                            width: 265,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot.data?.docs[index]
                                                      ['task'],
                                                  style: const TextStyle(
                                                      color: Vx.gray500,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                ),
                                                Text(
                                                  snapshot.data?.docs[index]
                                                      ['Date'],
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      color: Vx.gray500,
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                ),
                                              ],
                                            ),
                                          )
                                        : SizedBox(
                                            width: 265,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot.data?.docs[index]
                                                      ['task'],
                                                  style: const TextStyle(
                                                      color: Vx.gray700,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  snapshot.data?.docs[index]
                                                      ['Date'],
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Vx.gray500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }),
                )
              ],
            ))
          ]),
        ),
      ),
    );
  }

  void undoDeletion(String task, String category, String date, bool status,
      DocumentReference document) {
    document.delete();
    ref.add(
        {'task': task, 'Date': date, 'category': category, 'status': status});
    setState(() {});
  }

  Container swipeBackground(String task, String category, String date,
      bool status, DocumentReference document) {
    return Container(
      decoration: BoxDecoration(color: MyTheme.creamColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(
                Icons.delete_outline,
                color: Vx.gray400,
              ),
              Text(
                "This task was deleted",
                style: TextStyle(color: Vx.gray400),
              )
            ],
          ),
          InkWell(
            onTap: () {
              undoDeletion(task, category, date, status, document);
            },
            child: Container(
                height: 30,
                width: 60,
                decoration: BoxDecoration(
                    border: Border.all(color: Vx.gray300),
                    borderRadius: BorderRadius.circular(20)),
                child: const Center(
                  child: Text(
                    "UNDO",
                    style: TextStyle(
                        color: Vx.gray500, fontWeight: FontWeight.bold),
                  ),
                )),
          ),
        ],
      ).px12(),
    );
  }
}
