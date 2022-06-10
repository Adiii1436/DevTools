// ignore_for_file: public_member_api_docs, sort_constructors_first
class Items {
  String title;
  String imageUrl;
  String color;
  Items({required this.title, required this.imageUrl, required this.color});

  static List<Items> generateItems() {
    return [
      Items(
          title: "Notebook",
          imageUrl: "assets/Icons/post-it.png",
          color: "#d9c8c0"),
      Items(
          title: "Todo list",
          imageUrl: "assets/Icons/post-it.png",
          color: "f4717f"),
      Items(
          title: "Games",
          imageUrl: "assets/Icons/post-it.png",
          color: "544e50"),
      Items(
          title: "BMI", imageUrl: "assets/Icons/post-it.png", color: "#f9d162"),
      Items(
          title: "Resume",
          imageUrl: "assets/Icons/post-it.png",
          color: "#bdbdc7"),
      Items(
          title: "Github",
          imageUrl: "assets/Icons/post-it.png",
          color: "#dc9cfd"),
      Items(
          title: "Calculator",
          imageUrl: "assets/Icons/post-it.png",
          color: "#a6a184"),
      Items(
          title: "News", imageUrl: "assets/Icons/post-it.png", color: "#9de47c")
    ];
  }
}
