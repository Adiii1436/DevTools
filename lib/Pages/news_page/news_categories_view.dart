import 'dart:math';

import 'package:devtools/Pages/news_page/article_model.dart';
import 'package:devtools/Pages/news_page/news_view.dart';
import 'package:devtools/widgets/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'news.dart';

class NewsCategoriesView extends StatefulWidget {
  final String category;

  const NewsCategoriesView({super.key, required this.category});

  @override
  State<NewsCategoriesView> createState() => _NewsCategoriesViewState();
}

class _NewsCategoriesViewState extends State<NewsCategoriesView> {
  List<ArticleModel> articles = [];
  bool loading = true;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getNews();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreNews();
      }
    });
  }

  getMoreNews() async {
    var countries = [
      'au',
      'in',
      'us',
    ];
    Random random = Random();
    String country = countries[random.nextInt(countries.length)];
    News newsClass = News(category: widget.category, country: country);
    await newsClass.getNews();
    articles.addAll(newsClass.news);
    setState(() {});
  }

  getNews() async {
    News newsClass = News(category: widget.category, country: 'in');
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyTheme.creamColor,
          title: const Text(
            'NewsNet',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
          centerTitle: true,
          foregroundColor: Colors.green,
          elevation: 0.0,
        ),
        body: loading
            ? const Center(
                child: SizedBox(
                child: CircularProgressIndicator(),
              ))
            : Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7))),
                margin: const EdgeInsets.only(
                    bottom: 25, left: 10, right: 10, top: 10),
                child: Expanded(
                  child: Container(
                    // margin: const EdgeInsets.only(left: 10, right: 10),
                    padding: const EdgeInsets.only(top: 5),
                    // decoration: BoxDecoration(border: Border.all()),
                    child: ListView.builder(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: articles.length + 1,
                        itemBuilder: (context, index) {
                          if (index == articles.length) {
                            return const CupertinoActivityIndicator();
                          }
                          return NewsList(
                            headline: articles[index].title,
                            urlToImage: articles[index].urlToImage,
                            description: articles[index].description,
                            url: articles[index].url,
                          );
                        }),
                  ),
                ),
              ),
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  final String headline;
  final String urlToImage;
  final String description;
  final String url;

  const NewsList(
      {super.key,
      required this.headline,
      required this.urlToImage,
      required this.description,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => NewsViews(
                      url: url,
                    ))));
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: MyTheme.creamColor, borderRadius: BorderRadius.circular(7)),
        margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
        height: 300,
        child: Column(children: [
          Container(
            clipBehavior: Clip.antiAlias,
            height: MediaQuery.of(context).size.height * 0.22,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(7)),
            child: Image.network(
              urlToImage,
              fit: BoxFit.cover,
              // color: Colors.black45,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Center(
              child: Text(headline,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Text(
              description,
              maxLines: 2,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Vx.gray400,
                  overflow: TextOverflow.ellipsis),
            ),
          )
        ]),
      ),
    );
  }
}
