// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devtools/Pages/add_note.dart';
import 'package:devtools/Pages/edit_note.dart';
import 'package:devtools/home_widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:velocity_x/velocity_x.dart';

import 'package:devtools/home_widgets/items.dart';

class NoteBookPage extends StatefulWidget {
  final Items item;

  const NoteBookPage({super.key, required this.item});

  @override
  State<NoteBookPage> createState() => _NoteBookPageState();
}

class _NoteBookPageState extends State<NoteBookPage> {
  final ref = FirebaseFirestore.instance.collection('devTools_notebook');

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyTheme.creamColor,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AddNote()));
            },
            child: const Icon(Icons.add)),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            notesHeader(),
            notesList(),
          ],
        ));
  }

  Column notesHeader() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 40),
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
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditNote(
                                  docToEdit:
                                      snapshot.data!.docChanges[index].doc)));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data?.docChanges[index].doc['title'],
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                                snapshot.data?.docChanges[index].doc['content'])
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
