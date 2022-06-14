// ignore_for_file: public_member_api_docs, sort_constructors_first
class Items {
  String title;
  String imageUrl;
  String color;
  double width;
  double height;
  Items(
      {required this.title,
      required this.imageUrl,
      required this.color,
      required this.width,
      required this.height});

  static List<Items> generateItems() {
    return [
      Items(
          title: "Notebook",
          imageUrl: "assets/Images/2840443-removebg-preview(1).png",
          color: "#d9c8c0",
          width: 140,
          height: 115),
      Items(
          title: "Todo list",
          imageUrl: "assets/Images/smartphone-gcd4d097f4_1280.png",
          color: "#f4717f",
          width: 101,
          height: 122),
      Items(
          title: "Games",
          imageUrl: "assets/Images/3745105-removebg-preview.png",
          color: "544e50",
          width: 160,
          height: 110),
      Items(
          title: "BMI",
          imageUrl:
              "assets/Images/65Z_2112.w012.n001.20A.p20.20-removebg-preview.png",
          color: "#f9d162",
          width: 200,
          height: 110),
      Items(
          title: "Resume",
          imageUrl: "assets/Images/5215757-removebg-preview.png",
          color: "#bdbdc7",
          width: 130,
          height: 121),
      Items(
          title: "Github",
          imageUrl: "assets/Images/GitHub-Code-Repository-removebg-preview.png",
          color: "#dc9cfd",
          width: 125,
          height: 110),
      Items(
          title: "Calculator",
          imageUrl: "assets/Images/3609083-removebg-preview.png",
          color: "#a6a184",
          width: 135,
          height: 120),
      Items(
          title: "News",
          imageUrl:
              "assets/Images/morning_news_update_concept_illustration-removebg-preview.png",
          color: "#9de47c",
          width: 135,
          height: 120)
    ];
  }
}
