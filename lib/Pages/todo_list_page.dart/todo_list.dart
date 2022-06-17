import 'dart:math';
import 'package:devtools/Pages/todo_list_page.dart/add_task.dart';
import 'package:devtools/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  bool isChecked = false;
  final items = List<String>.generate(20, (i) => 'Item ${i + 1}');

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
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddTask()));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: const Icon(
          Icons.menu_outlined,
          color: Vx.gray500,
        ),
        actions: [
          IconButton(
              color: Vx.gray500,
              splashRadius: 25,
              onPressed: () {},
              icon: const Icon(Icons.search)),
          IconButton(
              color: Vx.gray500,
              splashRadius: 25,
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_outlined))
        ],
      ),
      body: SafeArea(
        child: Container(
          // decoration: BoxDecoration(color: Colors.pink),
          margin: const EdgeInsets.only(left: 17, right: 17),
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
                    "TODAY'S TASKS",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Vx.gray500),
                  ).py12().px1(),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        Random random = Random();
                        Color? bg = myColors[random.nextInt(6)];
                        return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.horizontal,
                          onDismissed: (direction) {
                            deleteItem(index);
                          },
                          resizeDuration: const Duration(milliseconds: 1400),
                          background: swipeBackground(index, items[index]),
                          secondaryBackground:
                              swipeBackground(index, items[index]),
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
                                  value: isChecked,
                                  shape: const CircleBorder(),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                                isChecked
                                    ? Text(
                                        item,
                                        style: const TextStyle(
                                            color: Vx.gray500,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      )
                                    : Text(
                                        item,
                                        style: const TextStyle(
                                            color: Vx.gray700,
                                            fontWeight: FontWeight.bold),
                                      )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  void deleteItem(index) {
    items.removeAt(index);
    setState(() {});
  }

  void undoDeletion(index, item) {
    if (items[index] != item) {
      items.insert(index, item);
    }
    setState(() {});
  }

  Container swipeBackground(int index, String item) {
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
              undoDeletion(index, item);
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
