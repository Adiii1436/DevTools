// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:devtools/Pages/news_page/article_model.dart';

class News {
  final String category;
  final String country;
  List<ArticleModel> news = [];

  News({
    required this.category,
    required this.country,
  });

  Future<void> getNews() async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=$country&category=$category&language=en&pageSize=10&apiKey=515792a3b64e476e8882c85246bd732a';

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['url'] != null &&
            element['urlToImage'] != null &&
            element['description'] != null &&
            element['content'] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage']);

          news.add(articleModel);
        }
      });
    }
  }
}
