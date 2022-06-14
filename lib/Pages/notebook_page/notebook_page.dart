// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devtools/Pages/notebook_page/add_note.dart';
import 'package:devtools/Pages/notebook_page/edit_note.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widgets/items.dart';
import '../../widgets/themes.dart';

class NoteBookPage extends StatefulWidget {
  final Items item;

  const NoteBookPage({super.key, required this.item});

  @override
  State<NoteBookPage> createState() => _NoteBookPageState();
}

class _NoteBookPageState extends State<NoteBookPage> {
  final ref = FirebaseFirestore.instance.collection('devTools_notebook');

  List<Color?> myColors = [
    Colors.yellow[200],
    Colors.red[200],
    Colors.green[200],
    Colors.deepPurple[200],
    Colors.blue[200],
    Colors.pink[200],
    Colors.brown[200]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Notebook',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          backgroundColor: MyTheme.creamColor,
          elevation: 0.0,
        ),
        backgroundColor: MyTheme.creamColor,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                      context, MaterialPageRoute(builder: (_) => AddNote()))
                  .then((value) => setState(
                        () {},
                      ));
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            )),
        body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // notesHeader(),
          notesList(),
        ])));
  }

  Column notesHeader() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: const Text("Notebook",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold))
              .px12(),
        ),
      ],
    );
  }

  Expanded notesList() {
    return Expanded(
      child: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return StaggeredGridView.countBuilder(
                shrinkWrap: true,
                staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                crossAxisCount: 1,
                physics: const BouncingScrollPhysics(),
                itemCount:
                    snapshot.hasData ? snapshot.data?.docChanges.length : 0,
                itemBuilder: (context, index) {
                  Random random = Random();
                  Color? bg = myColors[random.nextInt(7)];
                  // String? myDateTime = snapshot
                  //     .data?.docChanges[index].doc['created']
                  //     .toString();
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditNote(
                                    docToEdit:
                                        snapshot.data!.docChanges[index].doc,
                                    mycolor: bg,
                                  ))).then((value) => setState(
                            () {},
                          ));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                          color: bg, borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data?.docChanges[index].doc['title'],
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              (snapshot.data?.docChanges[index].doc['content']
                                              .toString()
                                              .length ??
                                          0) <
                                      250
                                  ? snapshot
                                      .data?.docChanges[index].doc['content']
                                  : "${snapshot.data?.docChanges[index].doc['content'].toString().substring(0, 250)}.........",
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
