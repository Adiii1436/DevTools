// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:devtools/Pages/calculator_page/calculator_page.dart';
import 'package:devtools/Pages/games_page/games_page.dart';
import 'package:devtools/Pages/image_to_pdf_page/image_to_pdf_page.dart';
import 'package:devtools/Pages/news_page/news_page.dart';
import 'package:devtools/Pages/notebook_page/notebook_page.dart';
import 'package:devtools/Pages/todo_list_page/todo_list.dart';
import 'package:devtools/Pages/weather_page/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../widgets/hex_color.dart';
import '../../widgets/items.dart';
import '../bmi_page/bmi_page.dart';

class HomeList extends StatelessWidget {
  const HomeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: .99 / 1),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 8,
        itemBuilder: (context, index) {
          final items = Items.generateItems();
          return InkWell(
              onTap: () {
                if (items[index].title == 'Notebook') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => NoteBookPage(
                                item: items[index],
                              ))));
                } else if (items[index].title == 'Todo list') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const TodoListPage())));
                } else if (items[index].title == 'BMI') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const BmiPage())));
                } else if (items[index].title == 'Calculator') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const CalculatorPage())));
                } else if (items[index].title == 'News') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const NewsPage())));
                } else if (items[index].title == 'Weather') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const WeatherPage())));
                } else if (items[index].title == 'Games') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => MyGames())));
                } else if (items[index].title == 'Image to Pdf') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const ImageToPdf())));
                }
              },
              child: HomeItems(items: items[index]));
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
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: HexColor(items.color),
          borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(4),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          items.title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ).py12().centered(),
        Center(
          child: Image.asset(
            items.imageUrl,
            width: items.width,
            fit: BoxFit.fitWidth,
            height: items.height,
          ),
        ),
      ]),
    );
  }
}
