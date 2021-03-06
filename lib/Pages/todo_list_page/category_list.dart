import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devtools/Pages/todo_list_page/add_task_category.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widgets/themes.dart';

class CategoryList extends StatefulWidget {
  final category;
  final Color bg;

  const CategoryList({super.key, required this.category, required this.bg});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
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
    final docId = widget.category['category'];
    final ref = FirebaseFirestore.instance
        .collection('devTools_categories')
        .doc(docId)
        .collection("$docId list");
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: widget.bg,
          elevation: 0.0,
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('devTools_categories')
                      .doc(docId)
                      .delete()
                      .whenComplete(() => Navigator.pop(context));
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                ))
          ]),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          elevation: 0.0,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddTaskCategory(
                          category: widget.category,
                        ))).then((value) => setState(
                  () {},
                ));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 17, right: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 25, left: 5),
                child: const Text(
                  "TASKS",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Vx.gray500),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: ref.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                          final date = snapshot.data!.docs[index]['Date'];
                          return Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.horizontal,
                            onDismissed: (direction) {
                              snapshot.data!.docs[index].reference.delete();
                            },
                            resizeDuration: const Duration(seconds: 2),
                            background: swipeBackground(
                                task,
                                category,
                                date,
                                status,
                                snapshot.data!.docs[index].reference,
                                ref),
                            secondaryBackground: swipeBackground(
                                task,
                                category,
                                date,
                                status,
                                snapshot.data!.docs[index].reference,
                                ref),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Checkbox(
                                    checkColor: Colors.white,
                                    fillColor: MaterialStateProperty.all(bg),
                                    value: snapshot.data!.docs[index]['status'],
                                    shape: const CircleBorder(),
                                    onChanged: (bool? value) {
                                      setState(() {
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
                                      });
                                    },
                                  ),
                                  snapshot.data!.docs[index]['status']
                                      ? SizedBox(
                                          width: 265,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data?.docs[index]
                                                    ['task'],
                                                style: const TextStyle(
                                                    color: Vx.gray500,
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              ),
                                              Text(
                                                snapshot.data?.docs[index]
                                                    ['Date'],
                                                style: const TextStyle(
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
                                                MainAxisAlignment.spaceBetween,
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
                                                  color: Vx.gray700,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void undoDeletion(String task, String category, String date, bool status,
      DocumentReference document, ref) {
    document.delete();
    ref.add(
        {'task': task, 'Date': date, 'category': category, 'status': status});
    setState(() {});
  }

  Container swipeBackground(String task, String category, String date,
      bool status, DocumentReference document, ref) {
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
              undoDeletion(task, category, date, status, document, ref);
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
