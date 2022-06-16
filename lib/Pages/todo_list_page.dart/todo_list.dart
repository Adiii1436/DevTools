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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.creamColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
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
                      clipBehavior: Clip.antiAlias,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Dismissible(
                          key: Key(items[index]),
                          direction: DismissDirection.horizontal,
                          onDismissed: (direction) {},
                          background: Container(
                            decoration:
                                BoxDecoration(color: MyTheme.creamColor),
                            child: Row(
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
                            ).px12(),
                          ),
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
                                  fillColor:
                                      MaterialStateProperty.all(Colors.red),
                                  value: isChecked,
                                  shape: const CircleBorder(),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                                Text(
                                  item,
                                  style: const TextStyle(color: Vx.gray800),
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
}

//  GFCheckbox(
//                           size: GFSize.MEDIUM,
//                           inactiveBgColor: Colors.red,
//                           type: GFCheckboxType.circle,
//                           onChanged: (value) {
//                             setState(() {
//                               isChecked = value;
//                             });
//                           },
//                           value: isChecked,
//                           inactiveIcon: const Icon(
//                             Icons.circle,
//                             size: 30,
//                             color: Colors.white,
//                           )),

// Dismissible(
//   key: Key(item),
//   onDismissed: (direction) {
//     setState(() {
//       items.removeAt(index);
//     });
//   },
//   background: Container(
//     decoration:
//         BoxDecoration(color: MyTheme.creamColor),
//     child: Row(
//       children: const [
//         Icon(
//           Icons.delete_outline,
//           color: Vx.gray400,
//         ),
//         // SizedBox(
//         //   width: 5,
//         // ),
//         Text(
//           "This task was deleted",
//           style: TextStyle(color: Vx.gray400),
//         )
//       ],
//     ),
//   ),
//   child: Container(
//     height: MediaQuery.of(context).size.height * 0.08,
//     width: MediaQuery.of(context).size.width * 0.9,
//     margin: const EdgeInsets.symmetric(
//         vertical: 5, horizontal: 0),
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.white),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: <Widget>[
//         Checkbox(
//           checkColor: Colors.white,
//           fillColor:
//               MaterialStateProperty.all(Colors.red),
//           value: isChecked,
//           shape: const CircleBorder(),
//           onChanged: (bool? value) {
//             setState(() {
//               isChecked = value!;
//             });
//           },
//         ),
//         Text(
//           item,
//           style: const TextStyle(color: Vx.gray800),
//         )
//       ],
//     ),
//   ),
// );
