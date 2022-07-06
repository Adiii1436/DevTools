// ignore_for_file: public_member_api_docs, sort_constructors_first
class GamesModel {
  String gameName;
  String img;

  GamesModel({
    required this.gameName,
    required this.img,
  });

  static List<GamesModel> generateGames() {
    return [
      GamesModel(
          gameName: 'TicTacToe',
          img:
              'https://img.freepik.com/free-vector/hands-holding-pencils-play-tic-tac-toe-people-drawing-crosses-noughts-simple-game-children-flat-vector-illustration-strategy-concept-banner-website-design-landing-web-page_74855-24786.jpg?w=740&t=st=1657036004~exp=1657036604~hmac=b6873b62aba269bf79983e9d1bfa0b7af45100bd5ca1c609cb40bf6f149cb3f6')
    ];
  }
}
