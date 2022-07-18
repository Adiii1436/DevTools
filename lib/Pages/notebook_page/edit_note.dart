// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  final Color? mycolor;
  final docToEdit;

  const EditNote({Key? key, required this.docToEdit, required this.mycolor})
      : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  final CollectionReference ref =
      FirebaseFirestore.instance.collection('devTools_notebook');

  @override
  void initState() {
    title = TextEditingController(text: widget.docToEdit.data()!['title']);
    content = TextEditingController(text: widget.docToEdit.data()!['content']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.mycolor,
          elevation: 0.0,
          actions: [
            IconButton(
                onPressed: () {
                  widget.docToEdit.reference.update({
                    'title': title.text,
                    'content': content.text,
                    'created': DateTime.now()
                  }).whenComplete(() => Navigator.pop(context));
                },
                splashRadius: 20,
                icon: const Icon(Icons.save_outlined)),
            IconButton(
                onPressed: () {
                  widget.docToEdit.reference
                      .delete()
                      .whenComplete(() => Navigator.pop(context));
                },
                splashRadius: 20,
                icon: const Icon(Icons.delete_outlined))
          ],
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextField(
                controller: title,
                cursorColor: Colors.black38,
                style: const TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black26,
                  ),
                )),
            Expanded(
                child: TextField(
                    controller: content,
                    maxLines: null,
                    expands: true,
                    cursorColor: Colors.black38,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Note',
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      ),
                    ))),
          ]),
        ),
      ),
    );
  }
}
