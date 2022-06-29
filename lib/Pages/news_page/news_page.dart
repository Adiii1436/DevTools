import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:devtools/Pages/news_page/article_model.dart';
import 'package:devtools/Pages/news_page/news_categories_view.dart';
import 'package:devtools/Pages/news_page/news_view.dart';
import 'package:devtools/widgets/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:devtools/Pages/news_page/news_categories.dart';
import 'package:velocity_x/velocity_x.dart';

import 'news.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<NewsCategories> categories = [];
  List<ArticleModel> articles = [];
  bool loading = true;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    categories = NewsCategories.generateCategories();
    getNews();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreNews();
      }
    });
  }

  getMoreNews() async {
    // print('hehe');
    var categoris = [
      'business',
      'technology',
      'entertainment',
      'health',
      'science',
      'general'
    ];
    Random random = Random();
    String category = categoris[random.nextInt(6)];
    News newsClass = News(category: category);
    await newsClass.getNews();
    articles.addAll(newsClass.news);
    setState(() {});
  }

  getNews() async {
    News newsClass = News(category: 'general');
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
                child: Column(children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(7),
                            topRight: Radius.circular(7),
                            bottomRight: Radius.circular(7))),
                    margin: const EdgeInsets.only(
                        bottom: 15, left: 5, right: 5, top: 5),
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.94,
                    child: Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return HeaderList(
                              name: categories[index].name,
                              imgUrl: categories[index].imgUrl,
                            );
                          }),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 5),
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
                ]),
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
              child: Text(
                headline,
                maxLines: 2,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
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

class HeaderList extends StatelessWidget {
  final String name;
  final String imgUrl;
  const HeaderList({
    Key? key,
    required this.name,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsCategoriesView(
                      category: name.toLowerCase(),
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: MediaQuery.of(context).size.width * 0.35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Stack(alignment: AlignmentDirectional.center, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              imageUrl: imgUrl,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
          Container(
              clipBehavior: Clip.antiAlias,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ))
        ]),
      ),
    );
  }
}
