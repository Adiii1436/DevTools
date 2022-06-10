// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:devtools/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:devtools/home_widgets/items.dart';

class HomeList extends StatelessWidget {
  const HomeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: .92 / 1),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 8,
        itemBuilder: (context, index) {
          final items = Items.generateItems();
          return InkWell(onTap: () {}, child: HomeItems(items: items[index]));
        },
      ),
    );
  }
}

class HomeItems extends StatelessWidget {
  final Items items;

  const HomeItems({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: HexColor(items.color),
          borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(4),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          items.title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ).py12().px8(),
        // Container(
        //   width: 50,
        //   height: 50,
        //   child: Image.asset(items.imageUrl),
        // ),
      ]),
    );
  }
}
