// ignore_for_file: public_member_api_docs, sort_constructors_first
class NewsCategories {
  String name;
  String imgUrl;
  NewsCategories({
    required this.name,
    required this.imgUrl,
  });

  static List<NewsCategories> generateCategories() {
    return [
      NewsCategories(
          name: 'Business',
          imgUrl:
              'https://img.freepik.com/free-photo/group-diverse-people-having-business-meeting_53876-25060.jpg?w=1060&t=st=1656483321~exp=1656483921~hmac=6a0b53ec9c297b7f842e2a54c37eb7255ecdaaf43b2d26621ce0924ac5ad7c9'),
      NewsCategories(
          name: 'Entertainment',
          imgUrl:
              'https://cdn.pixabay.com/photo/2015/11/22/19/04/crowd-1056764_960_720.jpg'),
      NewsCategories(
          name: 'Health',
          imgUrl:
              'https://cdn.pixabay.com/photo/2016/02/20/21/41/vegetables-1212845_960_720.jpg'),
      NewsCategories(
          name: 'Science',
          imgUrl:
              'https://cdn.pixabay.com/photo/2013/07/18/10/55/dna-163466_960_720.jpg'),
      NewsCategories(
          name: 'Sports',
          imgUrl:
              'https://cdn.pixabay.com/photo/2012/11/28/11/11/football-67701_960_720.jpg'),
      NewsCategories(
          name: 'Technology',
          imgUrl:
              'https://cdn.pixabay.com/photo/2015/12/07/14/18/drone-1080844_960_720.jpg'),
    ];
  }
}
