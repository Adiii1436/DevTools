import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../widgets/themes.dart';

class AddNote extends StatelessWidget {
  final TextEditingController title = TextEditingController();
  final TextEditingController content = TextEditingController();

  final CollectionReference ref =
      FirebaseFirestore.instance.collection('devTools_notebook');

  AddNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyTheme.creamColor,
          elevation: 0.0,
          actions: [
            IconButton(
                onPressed: () {
                  ref.add({
                    'title': title.text,
                    'content': content.text,
                    'created': DateTime.now()
                  }).whenComplete(() => Navigator.pop(context));
                },
                splashRadius: 20,
                icon: const Icon(Icons.save_outlined)),
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
