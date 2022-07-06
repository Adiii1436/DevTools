import 'package:cached_network_image/cached_network_image.dart';
import 'package:devtools/Pages/games_page/games_model.dart';
import 'package:devtools/Pages/games_page/tictactoe.dart';
import 'package:flutter/material.dart';

class MyGames extends StatelessWidget {
  MyGames({Key? key}) : super(key: key);
  final games = GamesModel.generateGames();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          padding: const EdgeInsets.all(15),
          child: GridView.builder(
              itemCount: games.length,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.90 / 1),
              itemBuilder: (context, index) {
                // print(index);
                return InkWell(
                  onTap: () {
                    if (games[index].gameName == 'TicTacToe') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TicTacToePage()));
                    }
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(13)),
                    child: Column(children: [
                      CachedNetworkImage(
                        imageUrl: games[index].img,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        games[index].gameName,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ]),
                  ),
                );
              })),
    ));
  }
}
